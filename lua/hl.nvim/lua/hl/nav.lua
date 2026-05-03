local M = {}

-- Collect the first position of each gid group in the current buffer, sorted.
local function collect_groups()
  local fname = vim.api.nvim_buf_get_name(0)
  local items = require('hl').get_state()[fname]
  if not items or #items == 0 then return {} end

  local seen = {}
  local result = {}
  for _, h in ipairs(items) do
    if not seen[h.gid] then
      seen[h.gid] = true
      result[#result + 1] = { row = h.start_row, col = h.start_col }
    end
  end

  table.sort(result, function(a, b)
    return a.row == b.row and a.col < b.col or a.row < b.row
  end)

  return result
end

local function navigate(dir)
  local cursor = vim.api.nvim_win_get_cursor(0)
  local cur_row, cur_col = cursor[1] - 1, cursor[2]
  local groups = collect_groups()
  if #groups == 0 then return end

  if dir > 0 then
    for _, g in ipairs(groups) do
      if g.row > cur_row or (g.row == cur_row and g.col > cur_col) then
        vim.api.nvim_win_set_cursor(0, { g.row + 1, g.col })
        return
      end
    end
    vim.api.nvim_win_set_cursor(0, { groups[1].row + 1, groups[1].col })
  else
    for i = #groups, 1, -1 do
      local g = groups[i]
      if g.row < cur_row or (g.row == cur_row and g.col < cur_col) then
        vim.api.nvim_win_set_cursor(0, { g.row + 1, g.col })
        return
      end
    end
    vim.api.nvim_win_set_cursor(0, { groups[#groups].row + 1, groups[#groups].col })
  end
end

function M.next() navigate(1)  end
function M.prev() navigate(-1) end

return M
