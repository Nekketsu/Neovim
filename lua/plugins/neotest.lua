return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "Issafalcon/neotest-dotnet",
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-dotnet")
            },
        })

        local options = { noremap = true, silent = true }
        -- vim.keymap.set('n', 'ta', "<cmd>lua require('neotest').run.attach()<cr>", options, "Attach")
        -- vim.keymap.set('n', 'tf', "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", options, "Run File")
        -- vim.keymap.set('n', 'tF', "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", options, "Debug File")
        -- vim.keymap.set('n', 'tl', "<cmd>lua require('neotest').run.run_last()<cr>", options, "Run Last")
        -- vim.keymap.set('n', 'tL', "<cmd>lua require('neotest').run.run_last({ strategy = 'dap' })<cr>", options, "Debug Last")
        -- vim.keymap.set('n', 'tn', "<cmd>lua require('neotest').run.run()<cr>", options, "Run Nearest")
        -- vim.keymap.set('n', 'tN', "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", options, "Debug Nearest")
        -- vim.keymap.set('n', 'to', "<cmd>lua require('neotest').output.open({ enter = true })<cr>", options, "Output")
        -- vim.keymap.set('n', 'ts', "<cmd>lua require('neotest').run.stop()<cr>", options, "Stop")
        -- vim.keymap.set('n', 'tt', "<cmd>lua require('neotest').summary.toggle()<cr>", options, "Summary")

        vim.keymap.set('n', '<leader>ta', "<cmd>lua require('neotest').run.attach()<cr>", { desc = "Attach" })
        vim.keymap.set('n', '<leader>tf', "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", { desc = "Run File" })
        vim.keymap.set('n', '<leader>tF', "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", { desc = "Debug File" })
        vim.keymap.set('n', '<leader>tl', "<cmd>lua require('neotest').run.run_last()<cr>", { desc = "Run Last" })
        vim.keymap.set('n', '<leader>tL', "<cmd>lua require('neotest').run.run_last({ strategy = 'dap' })<cr>", { desc = "Debug Last" })
        vim.keymap.set('n', '<leader>tn', "<cmd>lua require('neotest').run.run()<cr>", { desc = "Run Nearest" })
        vim.keymap.set('n', '<leader>tN', "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", { desc = "Debug Nearest" })
        vim.keymap.set('n', '<leader>to', "<cmd>lua require('neotest').output.open({ enter = true })<cr>", { desc = "Output" })
        vim.keymap.set('n', '<leader>ts', "<cmd>lua require('neotest').run.stop()<cr>", { desc = "Stop" })
        vim.keymap.set('n', '<leader>tt', "<cmd>lua require('neotest').summary.toggle()<cr>", { desc = "Summary" })
    end
}
