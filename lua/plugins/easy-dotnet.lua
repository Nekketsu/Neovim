return {
    "GustavEikaas/easy-dotnet.nvim",
    dependencies = { "nvim-lua/plenary.nvim", 'mfussenegger/nvim-dap', 'folke/snacks.nvim', },
    config = function()
        require("easy-dotnet").setup({
            picker = "snacks",
            lsp = { enabled = false },
            debugger = {
                auto_register_dap = false
            }
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "cs",
            callback = function()
                vim.keymap.set('n', "<F6>", function() require("easy-dotnet").build_quickfix() end)
            end,
        })
    end
}
