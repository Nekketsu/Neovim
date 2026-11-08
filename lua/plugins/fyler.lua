return {
    'FylerOrg/fyler.nvim',
    opts = {
        kind = "split_left_most",
        mappings = {
            n = {
                ['q'] = { disabled = true },
                ['<Esc>'] = {
                    action = 'close',
                    desc = 'Close finder',
                },
                ['\\'] = {
                    action = 'close',
                    desc = 'Close finder',
                },
                ['<C-Q>'] = {
                    action = 'select',
                    args = { vsplit = true },
                    desc = 'Open in vertical split',
                },
            }
        },
        extensions = {
            git = { enabled = true, inline = true }
        },
        integrations = {
            icon = "nvim_web_devicons"
        },
        ui = {
            indent_guides = true
        }
    },
    keys = {
        { "\\", function() require("fyler").open() end }
    }
}
