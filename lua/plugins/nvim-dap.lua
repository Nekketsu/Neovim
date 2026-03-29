return {
    'mfussenegger/nvim-dap',
    dependencies = {
        "tedkat/nvim-dap-dotnet",
        "GustavEikaas/easy-dotnet.nvim",
        {
            "jbyuki/one-small-step-for-vimkind",
            keys = {
                {
                    '<leader>dL',
                    function()
                        require('osv').launch { port = 8086 }
                    end,
                    desc = 'Launch Lua adapter'
                }
            }
        }
    },
    config = function()
        local dap = require("dap")
        local dap_dotnet = require("nvim-dap-dotnet")
        local packages_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "packages")

        dap.adapters.nlua = function(callback, config)
            callback { type = "server", host = config.host or '127.0.0.1', port = config.port or 8086 }
        end

        dap.configurations.lua = {
            {
                type = "nlua",
                request = "attach",
                name = "Attach to running Neovim instance"
            }
        }

        dap.adapters.codelldb = {
            type = 'server',
            port = "${port}",
            executable = {
                -- CHANGE THIS to your path!
                -- command = bin_dir .. 'codelldb.cmd',
                command = vim.fs.joinpath(packages_dir, "codelldb", "extension", "adapter", "codelldb.exe"),
                args = {"--port", "${port}"},

                -- On windows you may have to uncomment this:
                detached = false,
            }
        }

        dap.configurations.cpp = {
            {
                name = "Launch file",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = true,
            },
        }

        dap.configurations.c = dap.configurations.cpp
        -- dap.configurations.rust = dap.configurations.cpp



        local function send_payload(client, payload)
            local rpc = require("dap.rpc")
            local msg = rpc.msg_with_content_length(vim.json.encode(payload))
            client.write(msg)
        end

        local function RunHandshake(self, request_payload)
            local utils = require("dap.utils")

            local debugAdapterLocation = vim.fn.stdpath("config")

            local sign_file_location = vim.fs.joinpath(debugAdapterLocation, "vsdbgsignature", "sign.js")
            local signResult = io.popen('node ' .. sign_file_location .. ' ' .. request_payload.arguments.value)
            if signResult == nil then
                utils.notify('error while signing handshake', vim.log.levels.ERROR)
                return
            end
            local signature = signResult:read("*a")
            signature = string.gsub(signature, '\n', '')
            local response = {
                type = "response",
                seq = 0,
                command = "handshake",
                request_seq = request_payload.seq,
                success = true,
                body = {
                    signature = signature
                }
            }
            send_payload(self.client, response)
        end

        local extensions_path = vim.fs.joinpath(vim.env.USERPROFILE, ".vscode\\extensions")
        local pattern = "ms-dotnettools.csharp-*"
        local vsdbg_path = vim.fn.glob(vim.fs.joinpath(extensions_path, pattern), true, true)[1]

        dap.adapters.coreclr = {
            id='coreclr',
            type='executable',
            command=vim.fs.joinpath(vsdbg_path, ".debugger", "x86_64", "vsdbg-ui.exe"),
            args={ '--interpreter=vscode' },
            options={
                externalTerminal = true,
            },
            runInTerminal=true,
            -- console = "externalTerminal",
            reverse_request_handlers={
                handshake=RunHandshake,
            },
        }

        if not dap.adapters.netcoredbg then
            dap.adapters.netcoredbg = {
                type = "executable",
                -- command = vim.fn.exepath("netcoredbg"),
                command = vim.fs.joinpath(packages_dir, "netcoredbg", "netcoredbg", "netcoredbg.exe"),
                args = { "--interpreter=vscode" },
                -- console = "internalConsole",
            }
        end

        dap.configurations.cs = {
            {
                type = "coreclr",
                -- type = "netcoredbg",
                name = "launch - netcoredbg",
                request = "launch",
                program = function()
                    return dap_dotnet.build_artifact_dll_path()
                end,
            },
        }


        -- Define VSCode-like icons for breakpoints
        -- vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint', linehl = '', numhl = '' }) -- Solid circle (red)
        -- vim.fn.sign_define('DapBreakpointCondition', { text = '◆', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' }) -- Diamond (yellow)
        -- vim.fn.sign_define('DapLogPoint', { text = '◉', texthl = 'DapLogPoint', linehl = '', numhl = '' }) -- Hollow circle (blue)
        -- vim.fn.sign_define('DapStopped', { text = '➔', texthl = 'DapStopped', linehl = 'Debug', numhl = '' }) -- Right arrow (blue)
        -- vim.fn.sign_define('DapBreakpointRejected', { text = '✖', texthl = 'DapBreakpointRejected', linehl = '', numhl = '' }) -- Cross (gray)


        -- Define signs with texthl pointing to the highlight groups
        vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
        vim.fn.sign_define('DapBreakpointCondition', { text = '◆', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
        vim.fn.sign_define('DapLogPoint', { text = '◌', texthl = 'DapLogPoint', linehl = '', numhl = '' })
        vim.fn.sign_define('DapStopped', { text = '➔', texthl = 'DapStopped', linehl = 'DapStoppedLine', numhl = '' })
        vim.fn.sign_define('DapBreakpointRejected', { text = '✖', texthl = 'DapBreakpointRejected', linehl = '', numhl = '' })

        -- Apply VSCode-like highlight groups
        vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#E51400" })         -- Red
        vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = "#F7BA44" }) -- Orange
        vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#3794FF" })           -- Blue
        vim.api.nvim_set_hl(0, "DapStopped", { fg = "#16C60C" })            -- Green
        vim.api.nvim_set_hl(0, "DapBreakpointRejected", { fg = "#848484" }) -- Gray

        -- Optional: Highlight the current execution line
        vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#1E1E1E" }) -- Subtle line highlight
    end,
    keys = {
        { "<leader>d", "", desc = "+debug", mode = { "n", "v" } },
        { '<F5>', function() require('dap').continue() end, desc = "Run / Continue" },
        { '<S-F5>', function() require('dap').terminate() end, desc = "Stop" },
        { '<F10>', function() require('dap').step_over() end, desc = "Step over" },
        { '<F11>', function() require('dap').step_into() end, desc = "Step into" },
        { '<F12>', function() require('dap').step_out() end, desc = "Step out" },
        { '<F9>', function() require('dap').toggle_breakpoint() end, desc = "Toggle breakpoint" },
        -- { '<Leader>bp', function() require('dap').toggle_breakpoint() end, { desc = "Toggle breakpoint "}},
        -- { '<Leader>bc', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = "Breakpoint Condition" }},
        -- { '<Leader>bL', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { desc = "Log breakpoint" }},
        -- { '<Leader>dr', function() require('dap').repl.open() end},
        -- { '<Leader>dl', function() require('dap').run_last() end},
        -- { '<leader>dw', desc = "+widgets" },
        -- { '<Leader>dwh', function() require('dap.ui.widgets').hover() end, mode = {'n', 'v'}, desc = "Widgets: hover"},
        -- { '<Leader>dwp', function() require('dap.ui.widgets').preview() end, mode = {'n', 'v'}, desc = "Widgets: preview"},
        -- { '<Leader>dwf', function() local widgets = require('dap.ui.widgets') widgets.centered_float(widgets.frames) end, desc = "Widgets: frames" },
        -- { '<Leader>dws', function() local widgets = require('dap.ui.widgets') widgets.centered_float(widgets.scopes) end, desc = "Widgets: scopes" },

        {
            "<leader>dR",
            function()
                local dap = require("dap")
                local extension = vim.fn.expand("%:e")
                dap.run(dap.configurations[extension][1])
            end,
            desc = "Run default configuration",
        },
        {
            "<leader>dB",
            function()
                require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end,
            desc = "Breakpoint Condition",
        },
        {
            "<leader>db",
            function()
                require("dap").toggle_breakpoint()
            end,
            desc = "Toggle Breakpoint",
        },
        {
            "<Leader>bL",
            function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
            end,
            desc = "Log breakpoint"
        },
        {
            "<leader>dc",
            function()
                require("dap").continue()
            end,
            desc = "Continue",
        },
        {
            "<leader>da",
            function()
                require("dap").continue({ before = get_args })
            end,
            desc = "Run with Args",
        },
        {
            "<leader>dC",
            function()
                require("dap").run_to_cursor()
            end,
            desc = "Run to Cursor",
        },
        {
            "<leader>dg",
            function()
                require("dap").goto_()
            end,
            desc = "Go to Line (No Execute)",
        },
        {
            "<leader>di",
            function()
                require("dap").step_into()
            end,
            desc = "Step Into",
        },
        {
            "<leader>dj",
            function()
                require("dap").down()
            end,
            desc = "Down",
        },
        {
            "<leader>dk",
            function()
                require("dap").up()
            end,
            desc = "Up",
        },
        {
            "<leader>dl",
            function()
                require("dap").run_last()
            end,
            desc = "Run Last",
        },
        {
            "<leader>dO",
            function()
                require("dap").step_out()
            end,
            desc = "Step Out",
        },
        {
            "<leader>do",
            function()
                require("dap").step_over()
            end,
            desc = "Step Over",
        },
        {
            "<leader>dp",
            function()
                require("dap").pause()
            end,
            desc = "Pause",
        },
        {
            "<leader>dr",
            function()
                require("dap").repl.toggle()
            end,
            desc = "Toggle REPL",
        },
        {
            "<leader>ds",
            function()
                require("dap").session()
            end,
            desc = "Session",
        },
        {
            "<leader>dt",
            function()
                require("dap").terminate()
            end,
            desc = "Terminate",
        },
        -- {
        --     "<leader>dw",
        --     function()
        --         require("dap.ui.widgets").hover()
        --     end,
        --     desc = "Widgets",
        -- },
    }
}
