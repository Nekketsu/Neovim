local Terminal = nil

-- Define a Quake-style terminal
local quake_terminal_id = -1
local quake_terminal = nil
local current_term = nil

local function get_or_create_quake_terminal()
    if not quake_terminal then
        quake_terminal = Terminal:new({
            id = quake_terminal_id,
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
                vim.keymap.set("t", "<Esc>", function() if quake_terminal then quake_terminal:toggle() end end, { buffer = 0 })
            end,
        })
        quake_terminal:spawn()
    end

    return quake_terminal
end

-- Toggle function for the Quake-style terminal
local function quake_toggle()
    local quake_terminal = get_or_create_quake_terminal()
    quake_terminal:toggle()
end

local function GetMotion(type)
    -- Get the motion range
    local start_pos = vim.fn.getpos("'[")
    local end_pos = vim.fn.getpos("']")

    -- Extract the selected lines
    local lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)

    -- If the selection is single-line, extract the range of the line
    if type == 'char' then
        lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
    end

    local motion_text = table.concat(lines, "\n") -- Concatenate lines if it's multiline

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
    local start = math.max(start_pos[2] - 1, 0)
    local finish = math.max(end_pos[2], 1)
    local lines = vim.api.nvim_buf_get_lines(0, start, finish, false)

    local mode = vim.fn.mode()
    if mode == "v" then
        lines[1] = string.sub(lines[1], start_pos[3])
        lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
    elseif mode == "V" then
        -- Nothing to do
    else
        for i, line in ipairs(lines) do
            lines[i] = string.sub(line, start_pos[3], end_pos[3])
        end
    end

    -- Concatenate all lines into a single string with newlines
    local selection_text = table.concat(lines, "\n")

    return selection_text
end

local function get_or_create_terminal(id)
    local term = require("toggleterm.terminal").get(id)
    if not term then
        term = require("toggleterm.terminal").get_or_create_term(id)
        term:spawn()
    end

    return term
end

local function send_motion_to_terminal(id)
    if id == quake_terminal_id then
        current_term = get_or_create_quake_terminal()
    else
        current_term = get_or_create_terminal(id)
    end
    vim.go.operatorfunc = "v:lua.require'quake-terminal'.send_motion_to_terminal"
end



local M = {}

M.setup = function()
    vim.cmd [[
            let &shell = executable('pwsh') ? 'pwsh' : 'powershell'
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

    Terminal = require('toggleterm.terminal').Terminal


    vim.keymap.set("n", "º", quake_toggle)

    -- Quake terminal
    -- Send visual selection
    vim.keymap.set("v", [[<leader>º]], function()
        local visual = GetVisual()
        get_or_create_quake_terminal():send(visual .. "\n", false)
    end)
    -- Send motion
    vim.keymap.set("n", [[<leader>º]], function()
        send_motion_to_terminal(quake_terminal_id)
        return "g@"
    end, { expr = true })
    -- Send current line
    vim.keymap.set("n", [[<leader>ºº]], function()
        send_motion_to_terminal(quake_terminal_id)
        return "g@_"
    end, { expr = true })
    -- Send whole file
    vim.keymap.set("n", [[<leader><leader>º]], function()
        local file = GetFile()
        get_or_create_quake_terminal():send(file .. "\n", false)
    end)

    -- Terminal
    -- Send visual selection
    vim.keymap.set("v", [[<leader><c-\>]], function()
        local visual = GetVisual()
        local id = tonumber(vim.v.count) or 1
        get_or_create_terminal(id):send(visual .. "\n", false)
    end)
    -- Send motion
    vim.keymap.set("n", [[<leader><c-\>]], function()
        local id = tonumber(vim.v.count) or 1
        send_motion_to_terminal(get_or_create_terminal(id))
        return "g@"
    end, { expr = true })
    -- Send current line
    vim.keymap.set("n", [[<leader><c-\><c-\>]], function()
        local line = vim.api.nvim_get_current_line()
        local id = tonumber(vim.v.count) or 1
        get_or_create_terminal(id):send(line .. "\n", false)
        return "g@_"
    end, { expr = true })
    -- Send whole file
    vim.keymap.set("n", [[<leader><leader><c-\>]], function()
        local file = GetFile()
        local id = tonumber(vim.v.count) or 1
        get_or_create_terminal(id):send(file .. "\n", false)
    end)
end

M.send_motion_to_terminal = function(type)
    print("SEND MOTION")
    local motion = GetMotion(type)
    current_term:send(motion .. "\n", false)
end

return M
