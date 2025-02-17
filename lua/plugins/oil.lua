return {
    'stevearc/oil.nvim',
    config = function()
        require("oil").setup({
            keymaps = {
                ["y."] = "actions.copy_entry_path",
                ["."] = "actions.open_cmdline",
                ["<Esc>"] = "actions.close",
                ["gq"] = "actions.close"
            },
            win_options = {
                signcolumn = "yes:2"
            }
        })
    end,
    keys = {
        {"-", "<cmd>Oil<CR>", desc = "Open parent directory" }
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
}
