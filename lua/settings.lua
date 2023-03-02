local indent = 4

-- vim.cmd [[syntax enable]]
-- vim.cmd [[filetype plugin indent on]]

vim.opt.expandtab = true
vim.opt.shiftwidth = indent
vim.opt.smartindent = true
vim.opt.tabstop = indent
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.scrolloff = 4
vim.opt.shiftround = true
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
-- vim.opt.wildmode = 'list:longest'
vim.wo.number = true
vim.opt.mouse = 'a'

vim.wo.wrap = false

vim.opt.conceallevel = 2

-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

-- Highlight on yank
-- vim.cmd [[au TextYankPost * lua vim.highlight.on_yank()]]
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim.opt.title = false

vim.opt.termguicolors = true

vim.opt.cursorlineopt = "both"
vim.opt.cursorline = true

vim.opt.virtualedit = "block"
vim.opt.inccommand = "split"

vim.o.mousemoveevent = true
