return {
    'mfussenegger/nvim-dap',
    config = function()

        local dap = require('dap')
        local bin_dir = vim.fn.stdpath('data') .. '\\mason\\bin\\'

        dap.adapters.coreclr = {
            type = 'executable',
            -- command = bin_dir .. 'netcoredbg.cmd',
            command = "C:\\Users\\Nekketsu\\AppData\\Local\\nvim-data\\mason\\packages\\netcoredbg\\netcoredbg\\netcoredbg.exe",
            args = {'--interpreter=vscode'}
        }

        dap.adapters.codelldb = {
            type = 'server',
            port = "${port}",
            executable = {
                -- CHANGE THIS to your path!
                -- command = bin_dir .. 'codelldb.cmd',
                command = "C:\\Users\\Nekketsu\\AppData\\Local\\nvim-data\\mason\\packages\\codelldb\\extension\\adapter\\codelldb.exe",
                args = {"--port", "${port}"},

                -- On windows you may have to uncomment this:
                detached = false,
            }
        }

        -- dap.configurations.cs = {
        --     {
        --         type = "coreclr",
        --         name = "launch - netcoredbg",
        --         request = "launch",
        --         program = function()
        --             return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
        --         end,
        --     },
        -- }


        vim.g.dotnet_build_project = function()
            local default_path = vim.fn.getcwd() .. '/'
            if vim.g['dotnet_last_proj_path'] ~= nil then
                default_path = vim.g['dotnet_last_proj_path']
            end
            local path = vim.fn.input('Path to your *proj file', default_path, 'file')
            vim.g['dotnet_last_proj_path'] = path
            local cmd = 'dotnet build -c Debug -v q ' .. path
            print('')
            print('Cmd to execute: ' .. cmd)
            local f = os.execute(cmd)
            if f == 0 then
                print('\nBuild: ✔️ ')
            else
                print('\nBuild: ❌ (code: ' .. f .. ')')
            end
        end

        vim.g.dotnet_get_dll_path = function()
            local request = function()
                return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
            end

            if vim.g['dotnet_last_dll_path'] == nil then
                vim.g['dotnet_last_dll_path'] = request()
            else
                if vim.fn.confirm('Do you want to change the path to dll?\n' .. vim.g['dotnet_last_dll_path'], '&yes\n&no', 2) == 1 then
                    vim.g['dotnet_last_dll_path'] = request()
                end
            end

            return vim.g['dotnet_last_dll_path']
        end

        local dotnet_config = {
            {
                type = "coreclr",
                name = "launch - netcoredbg",
                request = "launch",
                program = function()
                    if vim.fn.confirm('Should I recompile first?', '&yes\n&no', 2) == 1 then
                        vim.g.dotnet_build_project()
                    end
                    return vim.g.dotnet_get_dll_path()
                end,
            },
        }

        dap.configurations.cs = dotnet_config
        dap.configurations.fsharp = dotnet_config


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


        local options = { noremap = true, silent = true }

        vim.keymap.set('n', '<F5>', function() require('dap').continue() end, { desc = "Run / Continue" })
        vim.keymap.set('n', '<S-F5>', function() require('dap').terminate() end, { desc = "Stop" })
        vim.keymap.set('n', '<F10>', function() require('dap').step_over() end, { desc = "Step over" })
        vim.keymap.set('n', '<F11>', function() require('dap').step_into() end, { desc = "Step into" })
        vim.keymap.set('n', '<F12>', function() require('dap').step_out() end, { desc = "Step out" })
        vim.keymap.set('n', '<F9>', function() require('dap').toggle_breakpoint() end, { desc = "Toggle breakpoint" })
        vim.keymap.set('n', '<Leader>bp', function() require('dap').toggle_breakpoint() end, { desc = "Toggle breakpoint "})
        vim.keymap.set('n', '<Leader>bc', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, options)
        vim.keymap.set('n', '<Leader>bL', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, options)
        vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end, options)
        vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end, options)
        vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
            require('dap.ui.widgets').hover()
        end)
        vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
            require('dap.ui.widgets').preview()
        end)
        vim.keymap.set('n', '<Leader>df', function()
            local widgets = require('dap.ui.widgets')
            widgets.centered_float(widgets.frames)
        end)
        vim.keymap.set('n', '<Leader>ds', function()
            local widgets = require('dap.ui.widgets')
            widgets.centered_float(widgets.scopes)
        end)
    end
}
