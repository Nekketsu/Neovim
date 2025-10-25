-- vim.keymap.set('n', '<C-l>', '<cmd>noh<CR>') -- Clear highlights
-- vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<Space>', '<Nop>')

vim.keymap.set('n', '<space>Y', function() require("pickers.spectre").toggle() end)

vim.keymap.set("n", "yoe", function()
    if vim.diagnostic.config().virtual_lines then
        vim.diagnostic.config({ virtual_lines = false, virtual_text = { severity = { min = vim.diagnostic.severity.WARN }}, signs = false})
    else
        vim.diagnostic.config({ virtual_lines = { severity = { min = vim.diagnostic.severity.WARN }}, virtual_text = false, severity = { min = vim.diagnostic.severity.WARN, signs = false }})
    end
end)
vim.keymap.set("n", "[oe", function() vim.diagnostic.config({ virtual_lines = { severity = { min = vim.diagnostic.severity.WARN }}, virtual_text = false, severity = { min = vim.diagnostic.severity.WARN}, signs = false }) end)
vim.keymap.set("n", "]oe", function() vim.diagnostic.config({ virtual_lines = false, virtual_text = { severity = { min = vim.diagnostic.severity.WARN }}, severity = { min = vim.diagnostic.severity.WARN}, signs = false }) end)

vim.keymap.set('x', '<Leader>/', '<Esc>/\\%V')
