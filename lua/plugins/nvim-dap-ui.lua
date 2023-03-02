return {
    {
        'rcarriga/nvim-dap-ui',
        dependencies = "mfussenegger/nvim-dap",
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup()

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            vim.keymap.set({'n', 'v'}, 'gk', "<cmd>lua require'dapui'.eval()<CR>", { noremap = true, silent = true })
        end
    },
}
