return {
    'stevearc/oil.nvim',
    config = function()
        require("oil").setup({
            keymaps = {
                ["y."] = { callback = "actions.copy_entry_path", mode = "n" },
                ["."] = { callback = "actions.open_cmdline", mode = "n"},
                -- ["<Esc>"] = { callback = "actions.close", mode = "n" },
                ["gq"] = { callback = "actions.close", mode = "n" }
            }
        })

        vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })

        vim.api.nvim_create_autocmd('FileType', {
            pattern = "oil",
            group = vim.api.nvim_create_augroup("oil_maps", { clear = true }),
            callback = function()
                vim.keymap.set("n", "<Esc>", function() require("oil").close() end, { buffer = true, remap = true })
            end,
        })
    end,
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
}
