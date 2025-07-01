return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'tpope/vim-unimpaired',
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

        local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

        -- Repeat movement with ; and ,
        -- ensure ; goes forward and , goes backward regardless of the last direction
        -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
        -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

        -- vim way: ; goes to the direction you were moving.
        vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
        vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

        -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
        vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

        local next_tab_repeat, prev_tab_repeat = ts_repeat_move.make_repeatable_move_pair(function() vim.cmd("tabnext") end, function() vim.cmd("tabprevious") end)
        vim.keymap.set({ "n", "x", "o" }, "gt", next_tab_repeat, { desc = "Go to the next tab page" })
        vim.keymap.set({ "n", "x", "o" }, "gT", prev_tab_repeat, { desc = "Go to the previous tab page" })

        local next_change_repeat, previous_change_repeat = ts_repeat_move.make_repeatable_move_pair(function() vim.cmd [[ execute "normal! g;" ]] end, function() vim.cmd [[ execute "normal! g," ]] end)
        vim.keymap.set("n", "g;", next_change_repeat, { noremap = true, desc = "Go to newer position in change list" })
        vim.keymap.set("n", "g,", previous_change_repeat, { noremap = true, desc = "Go to older position in change list" })

        local next_diagnostic, previous_diagnostic = ts_repeat_move.make_repeatable_move_pair(function () vim.diagnostic.jump({ count = 1 }) end, function() vim.diagnostic.jump({ count = -1 }) end)
        vim.keymap.set("n", "[d", previous_diagnostic, { desc = "Jump to the previous diagnostic in the current buffer"})
        vim.keymap.set("n", "]d", next_diagnostic, { desc = "Jump to the next diagnostic in the current buffer"})

        function Map(key, next, prev)
            local next_repeat, prev_repeat = ts_repeat_move.make_repeatable_move_pair( function() vim.cmd(next) end, function() vim.cmd(prev) end)
            vim.keymap.set("n", "]" .. key, next_repeat, { desc = next })
            vim.keymap.set("n", "[" .. key, prev_repeat, { desc = prev })
        end

        Map("q", "cnext", "cprevious")
        Map("<C-Q>", "cnfile", "cpfile")
        Map("l", "lnext", "lprevious")
        Map("<C-L>", "lnfile", "lpfile")
        Map("t", "tnext", "tprevious")
        Map("<C-T>", "ptnext", "ptprev")
        Map("a", "next", "prev")
        Map("b", "bprev", "bprevious")
    end
}
