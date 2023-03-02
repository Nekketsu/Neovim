return {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter' },
    config = function()
        local options = { noremap = true, silent = true }

        vim.keymap.set('n', '<leader>jt', ':TSJToggle<CR>', options)
        vim.keymap.set('n', '<leader>js', ':TSJSplit<CR>', options)
        vim.keymap.set('n', '<leader>jj', ':TSJJoin<CR>', options)

        local tsj = require('treesj')
        local tsj_utils = require('treesj.langs.utils')

        local langs = {
            c_sharp = {
                object = tsj_utils.set_preset_for_dict(),
                array = tsj_utils.set_preset_for_list(),
                initializer_expression = tsj_utils.set_preset_for_list(),
                formal_parameters = tsj_utils.set_preset_for_args(),
                argument_list = tsj_utils.set_preset_for_args(),
                block = tsj_utils.set_preset_for_statement(),
                declaration_list = tsj_utils.set_preset_for_statement(),
            }
        }

        tsj.setup({
            use_default_keymaps = false,
            max_join_length = 4000,
            langs = langs
        })
    end
}
