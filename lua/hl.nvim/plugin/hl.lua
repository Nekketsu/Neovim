local hl = require("hl")

local function opt_arg(s)
  return s ~= "" and s or nil
end

local function parse_color_arg(s)
  if not s or s == "" then return nil end
  return tonumber(s) or s
end

-- =========================
-- USER COMMANDS
-- =========================

vim.api.nvim_create_user_command("HlAdd", function(opts)
  local res = hl.add(parse_color_arg(opts.args))
  if res == "g@" then
    vim.schedule(function() vim.cmd("normal! g@") end)
  end
end, { nargs = "?", range = true })

vim.api.nvim_create_user_command("HlClear",    function() hl.clear_buffer() end, {})
vim.api.nvim_create_user_command("HlClearAll", function() hl.clear_all()    end, {})
vim.api.nvim_create_user_command("HlUndo",     function() hl.undo_last()    end, {})
vim.api.nvim_create_user_command("HlRedo",     function() hl.redo_last()    end, {})
vim.api.nvim_create_user_command("HlEnable",   function() hl.enable()       end, {})
vim.api.nvim_create_user_command("HlDisable",  function() hl.disable()      end, {})
vim.api.nvim_create_user_command("HlToggle",   function() hl.toggle()       end, {})
vim.api.nvim_create_user_command("HlRemoveCursor", function() hl.remove_at_cursor() end, {})

vim.api.nvim_create_user_command("HlSave", function(opts)
  hl.save(opt_arg(opts.args))
end, { nargs = "?" })

vim.api.nvim_create_user_command("HlLoad", function(opts)
  hl.load(opt_arg(opts.args))
end, { nargs = "?" })

vim.api.nvim_create_user_command("HlRemove", function(opts)
  hl.remove(parse_color_arg(opts.args))
end, { nargs = "?", range = true })

vim.api.nvim_create_user_command("HlList", function()
  local items = hl.get_state()[vim.api.nvim_buf_get_name(0)]
  if not items or #items == 0 then
    vim.notify("No highlights in current buffer", vim.log.levels.INFO)
    return
  end
  local lines = {}
  for i, h in ipairs(items) do
    local range = h.start_row == h.end_row
      and string.format("line %d, col %d-%d", h.start_row + 1, h.start_col, h.end_col)
      or  string.format("lines %d-%d", h.start_row + 1, h.end_row + 1)
    lines[i] = string.format("[%d] gid=%-3d  %-8s  %s", i, h.gid, tostring(h.color), range)
  end
  vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO)
end, {})

