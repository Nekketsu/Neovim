return {
    {
        "folke/trouble.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        -- config = function()
        --     local opts = { silent=true, noremap=true }
        --
        --     vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", opts)
        --     vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", opts)
        --     vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", opts)
        --     vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", opts)
        --     vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", opts)
        --     vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", opts)
        -- end,
        keys = {
            { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Trouble" },
            { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Trouble workspace diagnostics" },
            { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Trouble document diagnostics" },
            { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Trouble loclist" },
            { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Trouble quickfix" },
            { "gR", "<cmd>TroubleToggle lsp_references<cr>", desc = "Trouble lsp references" }
        }
    }
}
