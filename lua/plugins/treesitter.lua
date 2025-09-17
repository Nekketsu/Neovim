return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'tpope/vim-unimpaired',
        -- 'OXY2DEV/markview.nvim'
        -- 'JoosepAlviste/nvim-ts-context-commentstring',
    },
    build = ':TSUpdate',
    config = function()
---@diagnostic disable-next-line: missing-fields
        require'nvim-treesitter.configs'.setup {
            ensure_installed = {
                "c", "c_sharp", "cpp", "css", "go", "html", "javascript", "lua",
                "markdown", "markdown_inline", "norg", "python", "dap_repl", "regex", "rust", "scss", "typescript",
                "vim", "vimdoc", "query"
            },
            highlight = {
                enable = true,
            },
            indent = {
                enable = true
            },
            textobjects = {
                select = {
                    enable = true,

                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,

                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["am"] = "@function.outer",
                        ["im"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                        -- ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                        -- ["as"] = "@statement.outer",
                        -- ["is"] = "@statement.outer"
                        ["aa"] = "@parameter.outer",
                        ["ia"] = "@parameter.inner",
                        ["a*"] = "@comment.outer",
                        ["i*"] = "@comment.inner",
                        ["a/"] = "@comment.outer",
                        ["i/"] = "@comment.inner",
                        ["a?"] = "@conditional.outer",
                        ["i?"] = "@conditional.inner",
                        ["i@"] = "@loop.inner",
                        ["a@"] = "@loop.outer"
                    },
                },
                -- swap = {
                --     enable = true,
                --     swap_next = {
                --         ["<leader>sa"] = "@parameter.inner",
                --         ["<leader>sf"] = "@function.outer",
                --         ["<leader>sc"] = "@class.outer",
                --         -- ["<leader>ss"] = "@statement.outer"
                --     },
                --     swap_previous = {
                --         ["<leader>sA"] = "@parameter.inner",
                --         ["<leader>sF"] = "@function.outer",
                --         ["<leader>sC"] = "@class.outer",
                --         -- ["<leader>sS"] = "@statement.outer"
                --     },
                -- },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        ["]m"] = "@function.outer",
                        ["]]"] = "@class.outer",
                        ["]a"] = "@parameter.inner",
                        -- ["]s"] = "@statement.outer",
                        ["]/"] = "@comment.outer"
                    },
                    goto_next_end = {
                        ["]M"] = "@function.outer",
                        ["]["] = "@class.outer",
                        ["]A"] = "@parameter.inner",
                        -- ["]s"] = "@statement.outer",
                        ["]*"] = "@comment.outer"
                    },
                    goto_previous_start = {
                        ["[m"] = "@function.outer",
                        ["[["] = "@class.outer",
                        ["[a"] = "@parameter.inner",
                        -- ["[s"] = "@statement.outer",
                        ["[/"] = "@comment.outer"
                    },
                    goto_previous_end = {
                        ["[M"] = "@function.outer",
                        ["[]"] = "@class.outer",
                        ["[A"] = "@parameter.inner",
                        -- ["[s"] = "@statement.outer",
                        ["[*"] = "@comment.outer"
                    },
                    goto_next = {
                        ["]?"] = "@conditional.outer",
                        ["]@"] = "@loop.outer"
                    },
                    goto_previous = {
                        ["[?"] = "@conditional.outer",
                        ["[@"] = "@loop.outer"
                    }
                },
                lsp_interop = {
                    enable = true,
                    border = 'none',
                    peek_definition_code = {
                        ["<leader>df"] = "@function.outer",
                        ["<leader>dF"] = "@class.outer",
                    },
                },
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<CR>",
                    node_incremental = "<CR>",
                    scope_incremental = "<TAB>",
                    node_decremental = "<S-TAB>",
                },
            }
        }
    end
}
