return {
    "nvim-orgmode/telescope-orgmode.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-orgmode/orgmode",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        require("telescope").load_extension("orgmode")

        vim.keymap.set("n", "<leader>or", require("telescope").extensions.orgmode.refile_heading, { desc = "Refile heading" })
        vim.keymap.set("n", "<leader>oh", require("telescope").extensions.orgmode.search_headings, { desc = "Search headings" })
        vim.keymap.set("n", "<leader>ol", require("telescope").extensions.orgmode.insert_link, { desc = "Insert link" })
        vim.keymap.set("n", "<leader>of", function() require("telescope.builtin").find_files({ cwd = "~/org" }) end, { desc = "Find ORG files" })
    end,
}
