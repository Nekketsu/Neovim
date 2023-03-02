return {
    'kevinhwang91/nvim-ufo',
    config = function()
        vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
        vim.o.foldcolumn = '1'
        vim.o.foldnestmax = 1
        vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

        -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
        vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
        vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

        require('ufo').setup()

        local builtin = require("statuscol.builtin")
        require("statuscol").setup(
            {
                relculright = true,
                segments = {
                    {text = {builtin.foldfunc}, click = "v:lua.ScFa"},
                    {text = {"%s"}, click = "v:lua.ScSa"},
                    {text = {builtin.lnumfunc, " "}, click = "v:lua.ScLa"}
                }
            }
        )
    end,
    dependencies = {
        'kevinhwang91/promise-async',
        'luukvbaal/statuscol.nvim'
    }
}
