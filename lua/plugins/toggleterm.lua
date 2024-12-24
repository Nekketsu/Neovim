return {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
        -- local powershell_options = {
        --     shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell",
        --     shellcmdflag =
        --     "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
        --     shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
        --     shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
        --     shellquote = "",
        --     shellxquote = "",
        -- }
        --
        -- for option, value in pairs(powershell_options) do
        --     vim.opt[option] = value
        -- end

        vim.cmd [[
                let &shell = executable('pwsh') ? 'pwsh' : 'powershell'
                "let &shellcmdflag = '-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[''Out-File:Encoding'']=''utf8'';Remove-Alias -Force -ErrorAction SilentlyContinue tee;'
                let &shellcmdflag = '-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[''Out-File:Encoding'']=''utf8'';'
                let &shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
                let &shellpipe  = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
                set shellquote= shellxquote=
                ]]

        require("toggleterm").setup {
            open_mapping = [[<c-\>]],
            insert_mappings = false,
            terminal_mappings = false,
        }

        local Terminal = require('toggleterm.terminal').Terminal

        -- Define a Quake-style terminal
        local quake_terminal = nil

        -- Toggle function for the Quake-style terminal
        local function quake_toggle()
            if not quake_terminal then
                quake_terminal = Terminal:new({
                    display_name = "Quake",
                    hidden = true, -- Keeps it hidden when not in use
                    direction = "float",
                    float_opts = {
                        border = {"", "", "", "", "", "_", "", ""},
                        width = vim.o.columns, -- Adjust the width
                        height = math.floor(vim.o.lines * 0.4),  -- Adjust the height
                        row = 0,
                        winblend = 3, -- Transparency
                    },
                    on_open = function(term)
                        vim.cmd("startinsert")
                        vim.keymap.set("t", "<Esc>", quake_toggle, { buffer = 0 })
                    end,
                })

            end

            quake_terminal:toggle()
        end

        local function GetMotion()
            -- Get the motion range
            -- local start_pos = vim.api.nvim_buf_get_mark(0, "[")
            -- local end_pos = vim.api.nvim_buf_get_mark(0, "]")
            local start_pos = vim.fn.getpos('[')
            local end_pos = vim.fn.getpos(']')

            print("Pos:")
            vim.inspect(start_pos)
            vim.inspect(end_pos)
            -- Extract the lines in the motion range
            local lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)
            local motion_text = table.concat(lines, "\n") -- Concatenate lines if it's multiline
            vim.inspect(lines)
            vim.print(motion_text)

            return motion_text
        end

        local function GetFile()
            -- Get all lines of the current buffer (file)
            local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false) -- 0 = current buffer, range from line 0 to the end

            -- Concatenate all lines into a single string with newlines
            local file_content = table.concat(lines, "\n")

            return file_content
        end

        local function GetVisual()
            -- Get the start and end positions of the visual selection
            local start_pos = vim.fn.getpos("'<")
            local end_pos = vim.fn.getpos("'>")

            -- Extract the selected lines
            local lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)

            -- If the selection is single-line, extract the range of the line
            if #lines == 1 then
                lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
            end

            -- Concatenate all lines into a single string with newlines
            local selection_text = table.concat(lines, "\n")

            return selection_text
        end

        local function send_motion_to_terminal()
            local motion = GetMotion()
            print("Motion: " .. motion)
            quake_terminal:send(motion .. "\n", false)
        end

        vim.keymap.set("n", "º", quake_toggle, { noremap = true, silent = true })

        -- Quake terminal
        local trim_spaces = true
        vim.keymap.set("v", [[<leader>º]], function()
            quake_terminal:send(GetVisual() .. "\n", false)
        end)
        -- vim.keymap.set("n", [[<leader>º]], ":set opfunc=v:lua.send_motion_to_terminal<CR>g@", { noremap = true, silent = true })
        vim.keymap.set("n", [[<leader>º]], function()
            local old_func = vim.go.operatorfunc
            _G._send_motion_to_terminal = function()
                send_motion_to_terminal()

                vim.go.operatorfunc = old_func
                _G._send_motion_to_terminal = nil
            end
            vim.go.operatorfunc = "v:lua._send_motion_to_terminal"
            vim.api.nvim_feedkeys("g@", "n", false)
        end, { noremap = true, silent = true })
        vim.keymap.set("n", [[<leader>ºº]], function()
            quake_terminal:send(vim.api.nvim_get_current_line() .. "\n", false)
        end)
        -- Send whole file
        vim.keymap.set("n", [[<leader><leader>º]], function()
            quake_terminal:send(GetFile() .. "\n", false)
        end)

        -- Terminal
        local trim_spaces = true
        vim.keymap.set("v", [[<leader><c-\>]], function()
            local id = tonumber(vim.v.count) or 1
            local term = require("toggleterm.terminal").get_or_create_term(id)
            print("Terminal: " .. id .. ", " .. term.name)
            term:send(GetVisual() .. "\n", false)
        end)
        vim.keymap.set("n", [[<leader><c-\>]], function()
            local id = tonumber(vim.v.count) or 1
            local term = require("toggleterm.terminal").get_or_create_term(id)
            print("Terminal: " .. id .. ", " .. term.name)
            term:send(GetMotion() .. "\n", false)
        end)
        vim.keymap.set("n", [[<leader><c-\><c-\>]], function()
            local id = tonumber(vim.v.count) or 1
            local term = require("toggleterm.terminal").get_or_create_term(id)
            print("Terminal: " .. id .. ", " .. term.name)
            term:send(vim.api.nvim_get_current_line() .. "\n", false)
        end)
        -- Send whole file
        vim.keymap.set("n", [[<leader><leader><c-\>]], function()
            local id = tonumber(vim.v.count) or 1
            local term = require("toggleterm.terminal").get_or_create_term(id)
            print("Terminal: " .. id .. ", " .. term.name)
            term:send(GetFile() .. "\n", false)
        end)
    end
}
