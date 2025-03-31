return {
    "igorlfs/nvim-dap-view",
    dependencies = {
        "mfussenegger/nvim-dap",
    },
    opts = {},
    -- config = function()
    --     local dap, dapview = require("dap"), require("dap-view")
    --
    --     dapview.setup()
    --
    --     dap.listeners.before.attach.dapui_config = function()
    --         dapview.open()
    --     end
    --     dap.listeners.before.launch.dapui_config = function()
    --         dapview.open()
    --     end
    --     dap.listeners.before.event_terminated.dapui_config = function()
    --         dapview.close()
    --     end
    --     dap.listeners.before.event_exited.dapui_config = function()
    --         dapview.close()
    --     end
    -- end,
    keys = {
        { "<leader>dv", function () require("dap-view").toggle() end, desc = "Dap view" }
    },
    lazy = false
}
