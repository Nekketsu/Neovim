return {
    'tpope/vim-unimpaired',
    config = function()
        local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

        function Map(map, cmd, desc)
            local command = 'execute "normal \\<Plug>(unimpaired-' .. cmd .. '%s)"'

            local prev_argument_repeat, next_argument_repeat = ts_repeat_move.make_repeatable_move_pair(function() vim.cmd(string.format(command, "previous")) end, function() vim.cmd(string.format(command, "next")) end)
            local first_argument_repeat, last_argument_repeat = ts_repeat_move.make_repeatable_move_pair(function() vim.cmd(string.format(command, "first")) end, function() vim.cmd(string.format(command, "last")) end)

            -- local prev_argument_repeat, next_argument_repeat = ts_repeat_move.make_repeatable_move_pair(function() vim.cmd('execute "normal \\<Plug>(unimpaired-' .. cmd .. 'previous)"') end, function() vim.cmd('execute "normal \\<Plug>(unimpaired-' .. cmd .. 'next)"') end)
            -- local first_argument_repeat, last_argument_repeat = ts_repeat_move.make_repeatable_move_pair(function() vim.cmd('execute "normal \\<Plug>(unimpaired-' .. cmd .. 'first)"') end, function() vim.cmd('execute "normal \\<Plug>(unimpaired-' .. cmd .. 'last)"') end)

            vim.keymap.set("n", "[" .. map, prev_argument_repeat, { desc = "Previous " .. desc })
            vim.keymap.set("n", "]" .. map, next_argument_repeat, { desc = "Next " .. desc })
            vim.keymap.set("n", "[" .. string.upper(map), first_argument_repeat, { silent = true, desc = "First " .. desc })
            vim.keymap.set("n", "]" .. string.upper(map), last_argument_repeat, { silent = true, desc = "Last " .. desc })
        end

        Map("a", "", "arg")
        Map("b", "b", "buffer")
        Map("l", "l", "location")
        Map("q", "c", "quickfix")
        -- Map("t", "t", "tag")

        local next_directory_repeat, previous_directory_repeat = ts_repeat_move.make_repeatable_move_pair(function() vim.cmd [[ execute "normal \<Plug>(unimpaired-directory-next)" ]] end, function() vim.cmd [[ execute "normal \<Plug>(unimpaired-directory-previous)" ]] end)
        vim.keymap.set("n", "]f", next_directory_repeat, { desc = "Next file"})
        vim.keymap.set("n", "[f", previous_directory_repeat, { desc = "Previous file"})

        local next_context_repeat, previous_context_repeat = ts_repeat_move.make_repeatable_move_pair(function() vim.cmd [[ execute "normal \<Plug>(unimpaired-context-next)" ]] end, function() vim.cmd [[ execute "normal \<Plug>(unimpaired-context-previous)" ]] end)
        vim.keymap.set({ "n", "x", "o" }, "]n", next_context_repeat, { desc = "Next conflict"})
        vim.keymap.set({ "n", "x", "o" }, "[n", previous_context_repeat, { desc = "Previous conflict"})

        local next_lfile_repeat, previous_lfile_repeat = ts_repeat_move.make_repeatable_move_pair(function() vim.cmd [[ execute "normal \<Plug>(unimpaired-lfile-next)" ]] end, function() vim.cmd [[ execute "normal \<Plug>(unimpaired-lfile-previous)" ]] end)
        vim.keymap.set("n", "]<C-L>", next_lfile_repeat, { desc = "Next file location"})
        vim.keymap.set("n", "[<C-L>", previous_lfile_repeat, { desc = "Previous file location"})

        local next_cfile_repeat, previous_cfile_repeat = ts_repeat_move.make_repeatable_move_pair(function() vim.cmd [[ execute "normal \<Plug>(unimpaired-cfile-next)" ]] end, function() vim.cmd [[ execute "normal \<Plug>(unimpaired-cfile-previous)" ]] end)
        vim.keymap.set("n", "]<C-Q>", next_cfile_repeat, { desc = "Next file quickfix"})
        vim.keymap.set("n", "[<C-Q>", previous_cfile_repeat, { desc = "Previous file quickfix"})

        local next_pt_repeat, previous_pt_repeat = ts_repeat_move.make_repeatable_move_pair(function() vim.cmd [[ execute "normal \<Plug>(unimpaired-pt-next)" ]] end, function() vim.cmd [[ execute "normal \<Plug>(unimpaired-pt-previous)" ]] end)
        vim.keymap.set("n", "]<C-T>", next_pt_repeat, { desc = "Next tag (preview)"})
        vim.keymap.set("n", "[<C-T>", previous_pt_repeat, { desc = "Previous tag (preview)"})

        local next_diagnostic_repeat, previous_diagnostic_repeat = ts_repeat_move.make_repeatable_move_pair(function () vim.diagnostic.goto_next() end, function() vim.diagnostic.goto_prev() end)
        vim.keymap.set("n", "]d", next_diagnostic_repeat, { desc = "Next diagnostic"})
        vim.keymap.set("n", "[d", previous_diagnostic_repeat, { desc = "Previous diagnostic"})

        local next_diagnostic_error, previous_diagnostic_error = ts_repeat_move.make_repeatable_move_pair(function () vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end)
        vim.keymap.set("n", "]D", next_diagnostic_error, { desc = "Next error"})
        vim.keymap.set("n", "[D", previous_diagnostic_error, { desc = "Previous error"})

        local next_todo_comment_repeat, previous_todo_comment_repeat = ts_repeat_move.make_repeatable_move_pair(function () require("todo-comments").jump_next() end, function() require("todo-comments").jump_prev() end)
        vim.keymap.set("n", "]t", next_todo_comment_repeat, { desc = "Next todo comment"})
        vim.keymap.set("n", "[t", previous_todo_comment_repeat, { desc = "Previous todo comment"})
    end
}
