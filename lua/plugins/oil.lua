return {
    'stevearc/oil.nvim',
    config = function()
        require("oil").setup({
            keymaps = {
                ["y."] = "actions.copy_entry_path",
                ["."] = "actions.open_cmdline",
                -- ["<Esc>"] = "actions.close",
                ["gq"] = "actions.close"
            }
        })

        vim.api.nvim_create_autocmd('FileType', {
            pattern = "oil",
            group = vim.api.nvim_create_augroup("oil_maps", { clear = true }),
            callback = function()
                vim.keymap.set("n", "<Esc>", function() require("oil.actions").close.callback() end, { buffer = true })
                vim.keymap.set("n", "y.", function() require("oil.actions").copy_entry_path.callback() end, { buffer = true })
            end,
        })
    end,
    keys = {
        {"-", "<cmd>Oil<CR>", desc = "Open parent directory" }
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
}
