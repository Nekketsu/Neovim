return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    config = function()
        local harpoon = require("harpoon")

        harpoon:setup()

        vim.keymap.set("n", "<leader>ha", function() harpoon:list():append() end, { desc = "Add harpoon mark" })
        vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon" })

        for i = 1, 9 do
            vim.keymap.set("n", "<leader>h" .. i, function() harpoon:list():select(i) end, { desc = "Harpoon" .. i})
        end

        vim.keymap.set("n", "<C-M-p>", function() harpoon:list():prev() end, { desc = "Harpoon previous" })
        vim.keymap.set("n", "<C-M-n>", function() harpoon:list():next() end, { desc = "Harpoon next" })
    end,
    dependencies = {
        "nvim-lua/plenary.nvim",
    }
}
