return {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary",
    config = function()
        require("todo-comments").setup()
        vim.keymap.set("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next todo comment"})
        vim.keymap.set("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Previous todo comment"})
    end,
    keys = {
        { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo" },
        { "<leader>sT", function () Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
    }
}
