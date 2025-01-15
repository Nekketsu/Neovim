vim.o.termguicolors = true
-- vim.opt.background = "dark"

-- vim.cmd [[colorscheme tokyonight]]
vim.cmd [[colorscheme darkplus]]
-- vim.cmd [[colorscheme vscode]]
-- vim.cmd [[colorscheme catppuccin]]
-- vim.cmd [[colorscheme lunar]]
-- vim.cmd [[colorscheme moonfly]]
-- vim.cmd [[colorscheme aura]]

local hl_groups = vim.api.nvim_get_hl(0, {})

for key, hl_group in pairs(hl_groups) do
  if hl_group.italic then
    vim.api.nvim_set_hl(0, key, vim.tbl_extend("force", hl_group, {italic = false}))
  end
end

vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { underdotted = true, sp = "#ffcc66" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { underdotted = true, sp = "#4bc1fe" })
-- vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", {})
