-- vim.keymap.set('n', '<C-l>', '<cmd>noh<CR>') -- Clear highlights
-- vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<Space>', '<Nop>')

vim.keymap.set('n', '<space>Y', function() require("pickers.spectre").toggle() end)

vim.keymap.set("n", "yoe", function()
    if vim.diagnostic.config().virtual_lines then
        vim.diagnostic.config({ virtual_lines = false, virtual_text = true })
    else
        vim.diagnostic.config({ virtual_lines = true, virtual_text = false })
    end
end)
vim.keymap.set("n", "[oe", function() vim.diagnostic.config({ virtual_lines = true, virtual_text = false }) end)
vim.keymap.set("n", "]oe", function() vim.diagnostic.config({ virtual_lines = false, virtual_text = true }) end)
