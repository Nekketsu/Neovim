return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
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
    end,
    keys = {
        {'<leader>ta', "<cmd>lua require('neotest').run.attach()<cr>", { desc = "Attach" }},
        {'<leader>tf', "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", { desc = "Run File" }},
        {'<leader>tF', "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", { desc = "Debug File" }},
        {'<leader>tl', "<cmd>lua require('neotest').run.run_last()<cr>", { desc = "Run Last" }},
        {'<leader>tL', "<cmd>lua require('neotest').run.run_last({ strategy = 'dap' })<cr>", { desc = "Debug Last" }},
        {'<leader>tn', "<cmd>lua require('neotest').run.run()<cr>", { desc = "Run Nearest" }},
        {'<leader>tN', "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", { desc = "Debug Nearest" }},
        {'<leader>to', "<cmd>lua require('neotest').output.open({ enter = true })<cr>", { desc = "Output" }},
        {'<leader>ts', "<cmd>lua require('neotest').run.stop()<cr>", { desc = "Stop" }},
        {'<leader>tt', "<cmd>lua require('neotest').summary.toggle()<cr>", { desc = "Summary" }},
    }
}
