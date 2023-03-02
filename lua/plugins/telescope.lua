return {

    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        "debugloop/telescope-undo.nvim",
        "polirritmico/telescope-lazy-plugins.nvim"
    },
    config = function()
        local trouble = require('trouble.providers.telescope')
        local telescope = require('telescope')

        telescope.setup {
            defaults = {
                mappings = {
                    i = { ['<c-t>'] = trouble.open_with_trouble },
                    n = { ['<c-t>'] = trouble.open_with_trouble },
                },
            },
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown {
                    },
                },
                undo = {
                    -- telescope-undo.nvim config, see below
                },
                aerial = {
                    -- Display symbols as <root>.<parent>.<symbol>
                    show_nesting = {
                        ['_'] = false, -- This key will be the default
                        json = true,   -- You can set the option for specific filetypes
                        yaml = true,
                    }
                }
            }
        }

        telescope.load_extension("ui-select")
        telescope.load_extension("undo")
        telescope.load_extension("aerial")
        telescope.load_extension("dap")

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live grep" })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Buffers" })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Help tags" })
        vim.keymap.set('n', '<Leader>fo', builtin.oldfiles, { desc = "Old files" })
        vim.keymap.set('n', '<leader>fd', function() builtin.find_files({ cwd = vim.fn.stdpath("config") }) end, { desc = "Find dotfiles" })
        vim.keymap.set('n', '<leader>fD', function() builtin.live_grep({ cwd = vim.fn.stdpath("config") }) end, { desc = "Live grep dotfiles" })
        vim.keymap.set('n', '<leader>fa', function() telescope.extensions.aerial.aerial() end, { desc = "Live grep dotfiles" })


        vim.keymap.set('n', '<Leader>fn', '<cmd>Telescope neorg find_norg_files<CR>', { desc = "Find norg files" })
        vim.keymap.set('n', '<Leader>fr', '<cmd>Telescope orgmode search_headings<CR>', { desc = "Search orgmode headings" })
        vim.keymap.set('n', '<leader>fR', function() builtin.find_files({ cwd = "~/org" }) end, { desc = "Search orgmode files" })
        vim.keymap.set('n', '<Leader>fp', function() telescope.extensions.lazy_plugins.lazy_plugins() end, { desc = "Plugins configurations" })

        vim.keymap.set('n', 'gd', builtin.lsp_definitions, { desc = "LSP definitions" })
        -- vim.keymap.set('n', 'gd', '<cmd>lua require("omnisharp_extended").telescope_lsp_definitions()<CR>', options)
        vim.keymap.set('n', '<Leader>D', builtin.lsp_type_definitions, { desc = "LSP type definitions" })
        vim.keymap.set('n', 'gi', builtin.lsp_implementations, { desc = "LSP implementations" })
        vim.keymap.set('n', 'gr', builtin.lsp_references, { desc = "LSP references" })
        vim.keymap.set('n', '<Leader>ds', builtin.lsp_document_symbols, { desc = "LSP document symbols" })
        vim.keymap.set('n', '<Leader>ws', builtin.lsp_workspace_symbols, { desc = "LSP workspace symbols" })
        -- vim.keymap.set('n', '<Leader>ca', '<cmd>Telescope lsp_code_actions<CR>', options)
        -- vim.keymap.set('n', '<Leader>ts', '<cmd>Telescope treesitter<CR>', options)

        vim.keymap.set("n", "<leader>U", "<cmd>Telescope undo<cr>", { desc = "Telescope undo" })
    end
}
