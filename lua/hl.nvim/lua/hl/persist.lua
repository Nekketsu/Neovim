---@class HlPersist
local M = {}

local default_path = vim.fn.stdpath("state") .. "/hl.json"

local function sanitize_state(state)
  if type(state) ~= 'table' then return {} end
  local out = {}
  for fname, items in pairs(state) do
    if type(items) == 'table' and fname ~= '' then
      out[fname] = {}
      for _, it in ipairs(items) do
        if type(it) == 'table' then
          table.insert(out[fname], {
            start_row = it.start_row,
            start_col = it.start_col,
            end_row = it.end_row,
            end_col = it.end_col,
            color = it.color,
            gid = it.gid,
          })
        end
      end
    end
  end
  return out
end

---Save highlight state to disk
---@param state table
---@param path? string
function M.save(state, path)
  local p = path or default_path
  -- ensure directory exists
  local dir = vim.fn.fnamemodify(p, ':h')
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, 'p')
  end

  local safe = sanitize_state(state)
  local encoded = vim.fn.json_encode(safe)
  if not encoded then return false end
  return vim.fn.writefile({ encoded }, p) == 0
end

---Load highlight state from disk
---@param path? string
---@return table
function M.load(path)
  local p = path or default_path
  if vim.fn.filereadable(p) == 0 then
    return {}
  end

  local data = vim.fn.readfile(p)
  if not data or #data == 0 then
    return {}
  end

  local ok, decoded = pcall(vim.fn.json_decode, table.concat(data, "\n"))
  if not ok or type(decoded) ~= 'table' then
    return {}
  end
  return decoded
end

return M
