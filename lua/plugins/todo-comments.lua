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

        vim.keymap.set("n", "<leader>T", "<cmd>TodoTrouble<cr>", { desc = "TODO" })
    end
}
