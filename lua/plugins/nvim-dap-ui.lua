return {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio"
    },
    config = function()
        local dap, dapui = require("dap"), require("dapui")

        dapui.setup()

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end
    end,
    keys = {
        { 'gK', function() require("dapui").eval() end, mode = {'n', 'v'}, desc = "Evaluate expression" },
        { "<leader>du", function() require("dapui").toggle() end, desc = "Dap UI" },
        { "<Leader>dw", function() require("dapui").elements.watches.add(vim.fn.expand('<cword>')) end, desc = "Add variable to watches" },
        { "<Leader>dW", function()
            local word = vim.fn.expand('<cword>')
            word = vim.fn.input("Add watch: ", word)
            if word ~= "" then
                require("dapui").elements.watches.add(word)
            end
        end, desc = "Hover/eval a single value" },
    },
    lazy = false
}
