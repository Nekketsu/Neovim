return {
    'pocco81/high-str.nvim',
    config = function()
        vim.keymap.set('v', '<leader>Hh', ':<C-u>HSHighlight<CR>', { noremap = true, silent = true, desc = "Pastel yellow" })
        vim.keymap.set('v', '<leader>Hc', ':<C-u>HSHighlight 0<CR>', { noremap = true, silent = true, desc = "Cosmic charcoal" })
        vim.keymap.set('v', '<leader>Hy', ':<C-u>HSHighlight 1<CR>', { noremap = true, silent = true, desc = "Pastel yellow" })
        vim.keymap.set('v', '<leader>Ha', ':<C-u>HSHighlight 2<CR>', { noremap = true, silent = true, desc = "Aqua menthe" })
        vim.keymap.set('v', '<leader>Hv', ':<C-u>HSHighlight 3<CR>', { noremap = true, silent = true, desc = "Proton purple" })
        vim.keymap.set('v', '<leader>Hr', ':<C-u>HSHighlight 4<CR>', { noremap = true, silent = true, desc = "Orange red" })
        vim.keymap.set('v', '<leader>Hg', ':<C-u>HSHighlight 5<CR>', { noremap = true, silent = true, desc = "Office green" })
        vim.keymap.set('v', '<leader>Hb', ':<C-u>HSHighlight 6<CR>', { noremap = true, silent = true, desc = "Just blue" })
        vim.keymap.set('v', '<leader>Hp', ':<C-u>HSHighlight 7<CR>', { noremap = true, silent = true, desc = "Blush pink" })
        vim.keymap.set('v', '<leader>Hw', ':<C-u>HSHighlight 8<CR>', { noremap = true, silent = true, desc = "Cosmic latte" })
        vim.keymap.set('v', '<leader>Hf', ':<C-u>HSHighlight 9<CR>', { noremap = true, silent = true, desc = "Fallow brown" })

        vim.keymap.set('v', '<leader>Hd', ':<C-u>HSRmHighlight<CR>', { noremap = true, silent = true, desc = "Remove highlight" })
        vim.keymap.set('n', '<leader>HD', ':HSRmHighlight rm_all<CR>', { noremap = true, silent = true, desc = "Remove all highlights" })
    end
}
