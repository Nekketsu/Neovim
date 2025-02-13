return {

    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' },
        "nvim-telescope/telescope-ui-select.nvim",
        "debugloop/telescope-undo.nvim",
        "polirritmico/telescope-lazy-plugins.nvim",
        "milanglacier/yarepl.nvim"
    },
    config = function()
        local trouble = require('trouble.sources.telescope')
        local telescope = require('telescope')

        telescope.setup {
            -- pickers = {
            --     find_files = {
            --         theme = "ivy"
            --     }
            -- },
            defaults = require("telescope.themes").get_ivy({
                mappings = {
                    i = { ['<c-t>'] = trouble.open },
                    n = { ['<c-t>'] = trouble.open },
                },
            }),
            -- defaults = {
            --     mappings = {
            --         i = { ['<c-t>'] = trouble.open },
            --         n = { ['<c-t>'] = trouble.open },
            --     },
            -- },
            extensions = {
                -- fzf = {
                --     fuzzy = true,                    -- false will only do exact matching
                --     override_generic_sorter = true,  -- override the generic sorter
                --     override_file_sorter = true,     -- override the file sorter
                --     case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                --     -- the default case_mode is "smart_case"
                -- },
                ["ui-select"] = {
                    -- require("telescope.themes").get_dropdown {
                    -- },
                    -- require("telescope.themes").get_ivy({})
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

        -- telescope.load_extension("fzf")
        telescope.load_extension("ui-select")
        telescope.load_extension("undo")
        telescope.load_extension("aerial")
        telescope.load_extension("dap")
        -- telescope.load_extension("REPLShow")

        require("config/telescope/multigrep").setup()
    end,
    keys = {
        -- {'<leader>ff', require("telescope.builtin").find_files, { desc = "Find files" }},
        -- {'<leader>fg', require("telescope.builtin").live_grep, { desc = "Live grep" }},
        -- {'<leader>fb', require("telescope.builtin").buffers, { desc = "Buffers" }},
        -- {'<leader>fh', require("telescope.builtin").help_tags, { desc = "Help tags" }},
        -- {'<Leader>fo', require("telescope.builtin").oldfiles, { desc = "Old files" }},
        -- {'<Leader>fr', require("telescope.builtin").resume, { desc = "Resume" }},
        -- {'<leader>fd', function() require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config"), prompt_title = "Find dotfiles" }) end, { desc = "Find dotfiles" }},
        -- {'<leader>fD', function() require("telescope.builtin").live_grep({ cwd = vim.fn.stdpath("config"), prompt_title = "Live grep dotfiles" }) end, { desc = "Live grep dotfiles" }},
            -- {'<leader>fa', function() require('telescope').extensions.aerial.aerial() end, { desc = "Aerial" }},
        --
        --
        -- -- {'<Leader>fr', '<cmd>Telescope orgmode search_headings<CR>', { desc = "Search orgmode headings" }},
        -- -- {'<leader>fR', function() require("telescope.builtin").find_files({ cwd = "~/org" }) end, { desc = "Search orgmode files" }},
        -- {'<Leader>fc', function() require('telescope').extensions.lazy_plugins.lazy_plugins() end, { desc = "Plugins configurations" }},
        -- {'<Leader>fp', function() require("telescope.builtin").find_files({ cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy"), prompt_title = "Find plugins source" }) end, { desc = "Find plugins source" }},
        -- {'<Leader>fP', function() require("telescope.builtin").live_grep({ cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy"), prompt_title = "Live grep plugins source"  }) end, { desc = "Live grep plugins source" }},
        --
        -- {'gd', require("telescope.builtin").lsp_definitions, { desc = "LSP definitions" }},
        -- {'<Leader>D', require("telescope.builtin").lsp_type_definitions, { desc = "LSP type definitions" }},
        -- {'gri', require("telescope.builtin").lsp_implementations, { desc = "LSP implementations" }},
        -- {'grr', require("telescope.builtin").lsp_references, { desc = "LSP references" }},
        -- {'<Leader>ds', require("telescope.builtin").lsp_document_symbols, { desc = "LSP document symbols" }},
        -- -- {'<Leader>ws', require("telescope.builtin").lsp_workspace_symbols, { desc = "LSP workspace symbols" }},
        -- {'<Leader>ws', require("telescope.builtin").lsp_dynamic_workspace_symbols, { desc = "LSP workspace symbols" }},

        {"<leader>U", "<cmd>Telescope undo<cr>", { desc = "Telescope undo" }},

        -- {"<leader>rv", "<cmd>Telescope REPLShow<cr>", { desc = "Telescope REPLShow"}}
    }
}
