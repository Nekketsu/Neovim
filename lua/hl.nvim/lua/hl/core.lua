---@class HlHighlight
---@field start_row integer
---@field start_col integer
---@field end_row integer
---@field end_col integer
---@field color string|integer
---@field gid integer   Group id: all rows from one add() share the same gid, enabling atomic undo

local M = {}

local ns = vim.api.nvim_create_namespace("hl_plugin")
M.ns = ns

M.hl_groups = nil

-- Enable/disable flag
M.enabled = true

-- =========================
-- SETUP
-- =========================

---Initialize core with shared state and configuration
---@param state table<string, HlHighlight[]>
---@param opts? HlConfig
function M.setup(state, opts)
  opts = opts or {}

  M.hl_groups = {}

  if opts.highlights and #opts.highlights > 0 then
    for i, entry in ipairs(opts.highlights) do
      if type(entry) == "string" then
        M.hl_groups[i] = entry
      else
        M.hl_groups[i] = "HlColor" .. i
      end
    end
  else
    for i = 1, 4 do
      M.hl_groups[i] = "HlColor" .. i
    end
  end

  -- Pass 1: find max gid in existing state
  local max_gid = 0
  for _, items in pairs(state) do
    if type(items) == 'table' then
      for _, it in ipairs(items) do
        if type(it) == 'table' and it.gid and it.gid > max_gid then
          max_gid = it.gid
        end
      end
    end
  end
  M._next_gid = max_gid

  -- Pass 2: backfill missing gids (older saved states)
  for _, items in pairs(state) do
    if type(items) == 'table' then
      for _, it in ipairs(items) do
        if type(it) == 'table' and it.gid == nil then
          M._next_gid = M._next_gid + 1
          it.gid = M._next_gid
        end
      end
    end
  end
end

-- Enable/disable helpers
function M.set_enabled(v)
  M.enabled = not not v
end

function M.toggle_enabled()
  M.enabled = not M.enabled
  return M.enabled
end

local function file() return vim.api.nvim_buf_get_name(0) end

-- =========================
-- RENDER
-- =========================

---Render highlights for buffer (uses bufnr or current)
---@param state table
---@param bufnr? integer
function M.render(state, bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  -- If disabled, clear and return
  if not M.enabled then
    vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
    return
  end

  local fname = vim.api.nvim_buf_get_name(bufnr)

  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

  local items = state[fname]
  if not items then return end

  local line_count = vim.api.nvim_buf_line_count(bufnr)
  for _, h in ipairs(items) do
    local sr = math.max(0, math.min(h.start_row or 0, line_count - 1))
    local er = math.max(0, math.min((h.end_row or sr), line_count - 1))

    -- Get line lengths for start and end rows
    local sline = vim.api.nvim_buf_get_lines(bufnr, sr, sr + 1, false)[1] or ""
    local eline = vim.api.nvim_buf_get_lines(bufnr, er, er + 1, false)[1] or ""
    local s_len = #sline
    local e_len = #eline

    -- Clamp columns to valid ranges [0, line_len]
    local sc = math.max(0, math.min(h.start_col or 0, s_len))
    local ec = math.max(0, math.min(h.end_col or sc, e_len))

    local hl_name = "HlColor1"
    if type(h.color) == "string" and h.color ~= "" then
      hl_name = h.color
    elseif type(h.color) == "number" then
      hl_name = (M.hl_groups and M.hl_groups[h.color]) or ("HlColor" .. h.color)
    end

    vim.api.nvim_buf_set_extmark(bufnr, ns, sr, sc, {
      end_row = er,
      end_col = ec,
      hl_group = hl_name,
    })
  end
end

-- =========================
-- RANGE INSERTION
-- =========================

---Insert highlight range into state using region positions
---@param state table<string, HlHighlight[]>
---@param pos1 table  Position from getpos(): {bufnum, lnum, col, off}
---@param pos2 table  Position from getpos(): {bufnum, lnum, col, off}
---@param color string|integer
---@param mode? string  'v'|'V'|'\22'
function M.add_range(state, pos1, pos2, color, mode)
  local f = vim.api.nvim_buf_get_name(0)
  state[f] = state[f] or {}

  M._next_gid = (M._next_gid or 0) + 1
  local gid = M._next_gid

  local regions = vim.fn.getregionpos(pos1, pos2, { type = mode or 'v' })

  for _, region in ipairs(regions) do
    local spos = region[1]
    local epos = region[2]
    local row = spos[2] - 1
    local sc  = spos[3] - 1
    -- epos[3] is 1-indexed inclusive → 0-indexed exclusive = same value.
    -- Clamp handles v:maxcol returned for linewise selections.
    local line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1] or ""
    local ec = math.min(epos[3], #line)

    if sc < ec then
      table.insert(state[f], {
        start_row = row,
        start_col = sc,
        end_row   = row,
        end_col   = ec,
        color     = color,
        gid       = gid,
      })
    end
  end

  return
end


-- =========================
-- CLEAR
-- =========================

---@param state table
function M.clear_buffer(state)
  state[file()] = {}
  vim.api.nvim_buf_clear_namespace(vim.api.nvim_get_current_buf(), ns, 0, -1)
end

---@param state table
function M.clear_all(state)
  for k in pairs(state) do
    state[k] = {}
  end

  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    vim.api.nvim_buf_clear_namespace(b, ns, 0, -1)
  end
end

return M
