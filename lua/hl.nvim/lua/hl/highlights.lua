local M = {}

local default_colors = {
  "#f59e0b", -- yellow (amber-500)  — primary highlighter
  "#3b82f6", -- blue  (blue-500)
  "#22c55e", -- green (green-500)
  "#ef4444", -- red   (red-500)
}

local function is_hex_color(s)
  if type(s) ~= "string" then return false end
  return s:match("^#?%x%x%x%x%x%x$") ~= nil
end

---Setup highlight groups
---@param opts HlConfig
function M.setup(opts)
  opts = opts or {}

  -- If user provided explicit highlights, build HlColorN groups from that
  if opts.highlights and #opts.highlights > 0 then
    for i, entry in ipairs(opts.highlights) do
      local group = "HlColor" .. i
      if type(entry) == "table" then
        vim.api.nvim_set_hl(0, group, entry)
      elseif type(entry) == "string" then
        if is_hex_color(entry) then
          local hex = entry:match("#?(%x%x%x%x%x%x)")
          vim.api.nvim_set_hl(0, group, { bg = "#" .. hex, fg = "#18181b" })
        else
          -- entry is an existing group name: resolve and copy its attributes
          local attrs = vim.api.nvim_get_hl(0, { name = entry, link = false })
          vim.api.nvim_set_hl(0, group, attrs --[[@as vim.api.keyset.highlight]])
        end
      end
    end
    return
  end

  -- No highlights provided: create default HlColorN groups from default_colors
  for i, color in ipairs(default_colors) do
    vim.api.nvim_set_hl(0, "HlColor" .. i, {
      bg = color,
      fg = "#18181b", -- zinc-900: dark but not harsh pure black
    })
  end
end

return M
