return {
    'andymass/vim-matchup',
    init = function()
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
    config = function()
        local config = require('nvim-treesitter.configs')
        config.setup {
            matchup = {
                enabled = true,
            }
        }
    end
}
