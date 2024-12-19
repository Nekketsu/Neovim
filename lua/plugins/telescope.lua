return {

    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        "debugloop/telescope-undo.nvim",
        "polirritmico/telescope-lazy-plugins.nvim"
    },
    config = function()
        local trouble = require('trouble.sources.telescope')
        local telescope = require('telescope')

        telescope.setup {
            defaults = {
                mappings = {
                    i = { ['<c-t>'] = trouble.open },
                    n = { ['<c-t>'] = trouble.open },
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
    end,
    keys = {
        {'<leader>ff', require("telescope.builtin").find_files, { desc = "Find files" }},
        {'<leader>fg', require("telescope.builtin").live_grep, { desc = "Live grep" }},
        {'<leader>fb', require("telescope.builtin").buffers, { desc = "Buffers" }},
        {'<leader>fh', require("telescope.builtin").help_tags, { desc = "Help tags" }},
        {'<Leader>fo', require("telescope.builtin").oldfiles, { desc = "Old files" }},
        {'<leader>fd', function() require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") }) end, { desc = "Find dotfiles" }},
        {'<leader>fD', function() require("telescope.builtin").live_grep({ cwd = vim.fn.stdpath("config") }) end, { desc = "Live grep dotfiles" }},
        {'<leader>fa', function() require('telescope').extensions.aerial.aerial() end, { desc = "Live grep dotfiles" }},


        {'<Leader>fr', '<cmd>Telescope orgmode search_headings<CR>', { desc = "Search orgmode headings" }},
        {'<leader>fR', function() require("telescope.builtin").find_files({ cwd = "~/org" }) end, { desc = "Search orgmode files" }},
        {'<Leader>fp', function() require('telescope').extensions.lazy_plugins.lazy_plugins() end, { desc = "Plugins configurations" }},

        {'gd', require("telescope.builtin").lsp_definitions, { desc = "LSP definitions" }},
        -- {'gd', '<cmd>lua require("omnisharp_extended").telescope_lsp_definitions()<CR>', options},
        {'<Leader>D', require("telescope.builtin").lsp_type_definitions, { desc = "LSP type definitions" }},
        {'gi', require("telescope.builtin").lsp_implementations, { desc = "LSP implementations" }},
        {'gr', require("telescope.builtin").lsp_references, { desc = "LSP references" }},
        {'<Leader>ds', require("telescope.builtin").lsp_document_symbols, { desc = "LSP document symbols" }},
        -- {'<Leader>ws', require("telescope.builtin").lsp_workspace_symbols, { desc = "LSP workspace symbols" }},
        {'<Leader>ws', require("telescope.builtin").lsp_dynamic_workspace_symbols, { desc = "LSP workspace symbols" }},
        -- {'<Leader>ca', '<cmd>Telescope lsp_code_actions<CR>', options},
        -- {'<Leader>ts', '<cmd>Telescope treesitter<CR>', ptions},

        {"<leader>U", "<cmd>Telescope undo<cr>", { desc = "Telescope undo" }},
    }
}
