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

vim.opt.termguicolors = true

vim.opt.cursorlineopt = "both"
vim.opt.cursorline = true

vim.opt.virtualedit = "block"
vim.opt.inccommand = "split"

vim.o.mousemoveevent = true

vim.diagnostic.config({
    virtual_lines = false,
    virtual_text = { severity = { min = vim.diagnostic.severity.WARN }},
    -- underline = true,
    signs = false
    -- signs = { severity = {vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN, vim.diagnostic.severity.INFO, --[[ vim.diagnostic.severity.HINT ]]}}
})

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        vim.opt_local.formatoptions:remove({ 'r', 'o' })
    end
})
