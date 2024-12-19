-- vim.keymap.set('n', '<C-l>', '<cmd>noh<CR>') -- Clear highlights
-- vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<Space>', '<Nop>')

vim.keymap.set('n', '<space>Y', function() require("pickers.spectre").toggle() end)
