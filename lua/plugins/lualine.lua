return {
    'nvim-lualine/lualine.nvim',
    config = function()
        local wpm = require("wpm")

        require('lualine').setup {
            options = {
                icons_enabled = true,
                theme = 'tokyonight',
                -- theme = 'vscode',
                -- theme = 'lunar',
                component_separators = { left = '', right = ''},
                section_separators = { left = '', right = ''},
                disabled_filetypes = {},
                always_divide_middle = true,
                globalstatus = true
            },
            sections = {
                lualine_a = {'mode'},
                lualine_b = {'branch', 'diff', 'diagnostics'},
                lualine_c = { { 'filename', path = 3 }, --[[ { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available } ]]--[[ , 'lsp_progress' ]]},
                lualine_x = {
                    -- 'aerial',
                    {
                        require("noice").api.status.message.get_hl,
                        cond = require("noice").api.status.message.has,
                    },
                    {
                        require("noice").api.status.command.get,
                        cond = require("noice").api.status.command.has,
                        color = { fg = "#ff9e64" },
                    },
                    {
                        require("noice").api.status.mode.get,
                        cond = require("noice").api.status.mode.has,
                        color = { fg = "#ff9e64" },
                    },
                    {
                        require("noice").api.status.search.get,
                        cond = require("noice").api.status.search.has,
                        color = { fg = "#ff9e64" },
                    },
                    'encoding', 'fileformat', 'filetype', wpm.wpm, wpm.historic_graph
                },
                lualine_y = {
                    -- { "aerial",
                    --     -- The separator to be used to separate symbols in status line.
                    --     sep = ' ) ',
                    --
                    --     -- The number of symbols to render top-down. In order to render only 'N' last
                    --     -- symbols, negative numbers may be supplied. For instance, 'depth = -1' can
                    --     -- be used in order to render only current symbol.
                    --     depth = nil,
                    --
                    --     -- When 'dense' mode is on, icons are not rendered near their symbols. Only
                    --     -- a single icon that represents the kind of current symbol is rendered at
                    --     -- the beginning of status line.
                    --     dense = false,
                    --
                    --     -- The separator to be used to separate symbols in dense mode.
                    --     dense_sep = '.',
                    --
                    --     -- Color the symbol icons.
                    --     colored = true,
                    -- },
                    'progress'
                },
                lualine_z = {'location'}
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {'filename'},
                lualine_x = {'location'},
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            -- inactive_winbar = {
            --
            --     lualine_a = {},
            --     lualine_b = {},
            --     lualine_c = {
            --         -- { 'filename' }
            --     },
            --     lualine_x = {},
            --     lualine_y = {},
            --     lualine_z = {}
            -- },
            extensions = {}
        }
    end,
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true }
}
