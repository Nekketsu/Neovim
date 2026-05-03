---@class HlConfig
---@field highlights? table<integer, string|table>  list of highlight group names, hex colors (#rrggbb) or spec tables
---@field persist? boolean|table

local M = {}

---@type table<string, HlHighlight[]>
local _state = {}

---@type HlConfig
M.config = {}

---Read-only access to the highlight state.
---@return table<string, HlHighlight[]>
function M.get_state()
  return _state
end

-- Per-file redo stacks for undone highlights
local _redo_stack = {}

-- Per-file snapshots saved before clear_buffer / clear_all
local _clear_snapshots = {}

local _pending_op_color = nil

local core = require("hl.core")
local persist = require("hl.persist")

-- Ensure default highlight groups exist even if user doesn't call setup()
require("hl.highlights").setup(M.config)

-- =========================
-- SETUP
-- =========================

---Parse persist option: boolean | {enabled?, path?}
---@return boolean, string|nil
local function parse_persist_opts(p)
  if type(p) == "boolean" then return p, nil end
  if type(p) == "table" then
    return (p.enabled == nil or not not p.enabled), p.path
  end
  return false, nil
end

---Setup hl.nvim
---@param opts? HlConfig
---Examples:
--- require('hl').setup {
---   highlights = {
---     { bg = "#60a5fa", fg = "#000000" }, -- index 1 -> HlColor1
---     "#34d399",                            -- index 2 -> HlColor2 (hex)
---     "Search",                             -- index 3 -> copy existing group 'Search'
---   },
---   persist = { enabled = true, path = vim.fn.stdpath('data') .. '/hl.json' },
--- }
function M.setup(opts)
  opts = opts or {}
  M.config = opts

  require("hl.highlights").setup(opts)

  local persist_enabled, persist_path = parse_persist_opts(opts.persist)

  -- Load state first so core.setup initializes the gid counter from real data
  if persist_enabled then
    _state = persist.load(persist_path)
  else
    _state = {}
  end

  core.setup(_state, opts)

  -- Restore highlights on buffer events (always)
  local augroup = vim.api.nvim_create_augroup("HlNvim", { clear = true })
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
    group = augroup,
    callback = function()
      core.render(_state)
    end,
  })

  -- Save on exit only when persistence is enabled
  if persist_enabled then
    vim.api.nvim_create_autocmd("VimLeavePre", {
      group = augroup,
      callback = function()
        persist.save(_state, persist_path)
      end,
    })
  end
end

-- =========================
-- INTERNAL HELPERS
-- =========================

local function get_file()
  return vim.api.nvim_buf_get_name(0)
end

---Clamp end_col to valid range
local function clamp_end_col(row, col)
  local line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1] or ""
  return math.min(col, #line)
end

---Returns true if (row, col) falls inside highlight h
local function cursor_hits(h, row, col)
  local sr, er = h.start_row, h.end_row or h.start_row
  if row < sr or row > er then return false end
  local sc = row == sr and (h.start_col or 0) or 0
  local ec = row == er and (h.end_col or sc) or math.huge
  return col >= sc and col < ec
end

---Re-render every loaded buffer (respects core.enabled)
local function render_all_bufs()
  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(b) then
      core.render(_state, b)
    end
  end
end

-- =========================
-- PUBLIC API
-- =========================

---Unified add/operator: if called from visual, add highlight; otherwise start operator
---@param color? integer|string  Color index or group name. Defaults to 1.
function M.add(color)
  if color == nil then
    color = 1
  elseif type(color) == "number" then
    local n = core.hl_groups and #core.hl_groups or 4
    if color < 1 or color > n then color = 1 end
  end

  local mode = vim.fn.mode()

  if mode == 'v' or mode == 'V' or mode == '\22' then
    local pos1 = vim.fn.getpos('v')
    local pos2 = vim.fn.getpos('.')
    if (pos1[2] or 0) == 0 then return end

    local f = get_file()
    _redo_stack[f] = {}
    core.add_range(_state, pos1, pos2, color, mode)
    core.render(_state)

    vim.schedule(function() vim.cmd("normal! " .. vim.api.nvim_replace_termcodes("<Esc>", true, false, true)) end)
    return
  end

  _pending_op_color = color
  vim.o.operatorfunc = "v:lua.require'hl'._operator"
  return "g@"
end

---Clear highlights in current buffer
function M.clear_buffer()
  local f = get_file()
  local items = _state[f]
  if items and #items > 0 then
    _clear_snapshots[f] = _clear_snapshots[f] or {}
    table.insert(_clear_snapshots[f], {
      items = vim.deepcopy(items),
      redo  = vim.deepcopy(_redo_stack[f] or {}),
    })
  end
  _redo_stack[f] = {}
  core.clear_buffer(_state)
end

---Clear all highlights globally
function M.clear_all()
  for f, items in pairs(_state) do
    if items and #items > 0 then
      _clear_snapshots[f] = _clear_snapshots[f] or {}
      table.insert(_clear_snapshots[f], {
        items = vim.deepcopy(items),
        redo  = vim.deepcopy(_redo_stack[f] or {}),
      })
    end
  end
  _redo_stack = {}
  core.clear_all(_state)
end

---Force re-render
function M.render()
  core.render(_state)
end

---Enable highlights globally
function M.enable()
  core.set_enabled(true)
  render_all_bufs()
end

---Disable highlights globally
function M.disable()
  core.set_enabled(false)
  render_all_bufs()
end

---Toggle global highlight state
function M.toggle()
  core.toggle_enabled()
  render_all_bufs()
end

---Returns true if highlights are globally enabled
---@return boolean
function M.is_enabled()
  return core.enabled
end

---Returns the list of configured highlight group names.
---@return string[]
function M.get_highlights()
  return core.hl_groups or {}
end

---Returns the number of highlights in the current buffer.
---@return integer
function M.count()
  local items = _state[get_file()]
  return items and #items or 0
end

---Returns a statusline-friendly string, e.g. " hl:3" or " hl:off".
---@return string
function M.statusline()
  if not core.enabled then return " hl:off" end
  local n = M.count()
  return n > 0 and (" hl:" .. n) or ""
end

---Changes the color of all highlights under the cursor in the current buffer.
---@param new_color integer|string
function M.recolor(new_color)
  if new_color == nil then return end
  local f = get_file()
  local items = _state[f]
  if not items or #items == 0 then return end
  local cur = vim.api.nvim_win_get_cursor(0)
  local row, col = cur[1] - 1, cur[2]

  local changed = false
  for _, h in ipairs(items) do
    if cursor_hits(h, row, col) then
      h.color = new_color
      changed = true
    end
  end

  if changed then
    core.render(_state, vim.api.nvim_get_current_buf())
  end
end


function M.remove_at_cursor()
  local f = get_file()
  local items = _state[f]
  if not items or #items == 0 then return end
  local cur = vim.api.nvim_win_get_cursor(0)
  local row, col = cur[1] - 1, cur[2]

  local changed = false
  for i = #items, 1, -1 do
    if cursor_hits(items[i], row, col) then
      table.remove(items, i)
      changed = true
    end
  end

  if changed then
    core.render(_state, vim.api.nvim_get_current_buf())
  end
end

-- Remove highlights in file f that overlap a given range; optional color filter
local function _remove_range_for_file(f, start_row, start_col, end_row, end_col, filter)
  local items = _state[f]
  if not items or #items == 0 then return false end
  local changed = false
  for i = #items, 1, -1 do
    local h = items[i]
    if h.start_row >= start_row and h.start_row <= end_row then
      local sel_sc = (h.start_row == start_row) and start_col or 0
      local sel_ec = (h.start_row == end_row) and end_col or math.huge
      local hsc = h.start_col or 0
      local hec = h.end_col or hsc
      local overlap = not (hec <= sel_sc or hsc >= sel_ec)
      if overlap and (not filter or filter == h.color) then
        table.remove(items, i)
        changed = true
      end
    end
  end
  return changed
end

-- Execute removal over a resolved range, optionally escaping visual mode after
local function _apply_remove(start_row, start_col, end_row, end_col, filter, escape_visual)
  local changed = _remove_range_for_file(get_file(), start_row, start_col, end_row, end_col, filter)
  if changed then core.render(_state, vim.api.nvim_get_current_buf()) end
  if escape_visual then
    vim.schedule(function()
      vim.cmd("normal! " .. vim.api.nvim_replace_termcodes("<Esc>", true, false, true))
    end)
  end
end

---Unified remove: visual -> remove selection; normal -> remove highlight at cursor
---@param filter string|integer|nil  Optional filter (ignored for normal delete)
function M.remove(filter)
  local m = vim.fn.mode()

  if m == 'v' or m == 'V' or m == '\22' then
    local s = vim.fn.getpos('v')
    local e = vim.fn.getpos('.')
    if (s[2] or 0) == 0 then return end
    local start_row, start_col = s[2] - 1, s[3] - 1
    local end_row,   end_col   = e[2] - 1, e[3] - 1
    if start_row > end_row or (start_row == end_row and start_col > end_col) then
      start_row, end_row = end_row, start_row
      start_col, end_col = end_col, start_col
    end
    _apply_remove(start_row, start_col, end_row, clamp_end_col(end_row, end_col + 1), filter, true)
    return
  end

  -- Command range (:'<,'>HlRemove)
  local s = vim.fn.getpos("'<")
  local e = vim.fn.getpos("'>")
  if s and e and (s[2] or 0) ~= 0 and (e[2] or 0) ~= 0 then
    if s[2] > e[2] or (s[2] == e[2] and s[3] > e[3]) then s, e = e, s end
    _apply_remove(s[2] - 1, s[3] - 1, e[2] - 1, clamp_end_col(e[2] - 1, e[3]), filter, false)
    return
  end

  M.remove_at_cursor()
end

-- =========================
-- OPERATOR (TEXTOBJECT SUPPORT)
-- =========================

---Operator implementation (called by Neovim)
---@param _type string
function M._operator(_type)
  local s = vim.fn.getpos("'[")
  local e = vim.fn.getpos("']")
  if not s or not e or (s[2] or 0) == 0 or (e[2] or 0) == 0 then return end

  local f = get_file()
  _redo_stack[f] = {}

  local color = _pending_op_color
  _pending_op_color = nil

  local mode = 'v'
  if _type == 'line'  then mode = 'V'   end
  if _type == 'block' then mode = '\22' end

  core.add_range(_state, s, e, color, mode)
  core.render(_state)
end

---Undo last highlight in current buffer
function M.undo_last()
  local f = get_file()
  local items = _state[f]

  -- Buffer empty: restore from a clear snapshot
  if not items or #items == 0 then
    local snaps = _clear_snapshots[f]
    if snaps and #snaps > 0 then
      local snap = table.remove(snaps)
      -- Rebuild redo: pre-clear entries, then post-clear entries, then clear marker on top
      local new_redo = vim.deepcopy(snap.redo)
      for _, e in ipairs(_redo_stack[f] or {}) do
        table.insert(new_redo, e)
      end
      table.insert(new_redo, { is_clear = true })
      _redo_stack[f] = new_redo
      _state[f] = snap.items
      core.render(_state)
    end
    return
  end

  _redo_stack[f] = _redo_stack[f] or {}

  local last = items[#items]
  local gid = last and last.gid
  if not gid then
    local removed = table.remove(items)
    if removed then table.insert(_redo_stack[f], { removed }) end
    core.render(_state)
    return
  end

  local removed_group = {}
  for i = #items, 1, -1 do
    if items[i].gid == gid then
      table.insert(removed_group, 1, table.remove(items, i))
    else
      break
    end
  end

  if #removed_group > 0 then
    table.insert(_redo_stack[f], removed_group)
    core.render(_state)
  end
end

---Redo last undone highlight in current buffer
function M.redo_last()
  local f = get_file()
  local stack = _redo_stack[f]
  if not stack or #stack == 0 then return end

  local entry = table.remove(stack)
  if not entry then return end

  -- Redo a clear operation
  if entry.is_clear then
    local items = _state[f]
    if items and #items > 0 then
      _clear_snapshots[f] = _clear_snapshots[f] or {}
      table.insert(_clear_snapshots[f], {
        items = vim.deepcopy(items),
        redo  = {},
      })
    end
    _state[f] = {}
    core.render(_state)
    return
  end

  -- Redo a normal gid group
  if #entry == 0 then return end
  _state[f] = _state[f] or {}
  for _, h in ipairs(entry) do
    table.insert(_state[f], h)
  end
  core.render(_state)
end

---Save current state to disk (optional path)
---@param path string|nil
function M.save(path)
  persist.save(_state, path)
end

---Load state from disk (optional path) and render
---@param path string|nil
function M.load(path)
  local data = persist.load(path)
  _state = data or _state
  core.setup(_state, M.config)
  core.render(_state)
end

return M
