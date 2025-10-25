return {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary",
    config = function()
        require("todo-comments").setup()
        --
        -- vim.keymap.set("n", "]t", function()
        --     require("todo-comments").jump_next()
        -- end, { desc = "Next todo comment" })
        --
        -- vim.keymap.set("n", "[t", function()
        --     require("todo-comments").jump_prev()
        -- end, { desc = "Previous todo comment" })

        -- local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
        -- local next_todo_comment_repeat, previous_todo_comment_repeat = ts_repeat_move.make_repeatable_move_pair(function () require("todo-comments").jump_next() end, function() require("todo-comments").jump_prev() end)
        vim.keymap.set("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next todo comment"})
        vim.keymap.set("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Previous todo comment"})
    end,
    keys = {
        -- {"<leader>T", "<cmd>TodoTrouble<cr>", desc = "TODO Troube"},
        -- {"<leader>ft", "<cmd>TodoTelescope<cr>", desc = "TODO Telescope"}
        { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo" },
        { "<leader>sT", function () Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
    }
}
