---@param  forward boolean
local function go_wrap(forward)
    return function()
        require("demicolon.jump").repeatably_do(function(opts)
            local motion = opts.forward ~= false and 'gj' or 'gk'
            vim.cmd(string.format('normal! %s%s', vim.v.count1, motion))
        end, { forward = forward })
    end
end

local function go_change_list(forward)
    return function()
        require("demicolon.jump").repeatably_do(function(opts)
            local motion = opts.forward ~= false and 'g;' or 'g,'
            vim.cmd(string.format('normal! %s%s', vim.v.count1, motion))
        end, { forward = forward })
    end
end

-- return {
--     'mawkler/demicolon.nvim',
--     dependencies = {
--         'nvim-treesitter/nvim-treesitter',
--         'nvim-treesitter/nvim-treesitter-textobjects',
--         'jinh0/eyeliner.nvim'
--     },
--     opts = {
--         keymaps = {
--             repeat_motions = "stateful",
--             horizontal_motions = false,
--         }
--     },
--     keys = {
--         { "gj", go_wrap(true), desc = "Display lines downward" },
--         { "gk", go_wrap(false), desc = "Display lines upward" },
--         { "g;", go_change_list(true), desc = "Go to newer position in change list" },
--         { "g,", go_change_list(false), desc = "Go to older position in change list" },
--     }
-- }

return {
    "mawkler/demicolon.nvim",
    branch = "repeated",
    -- keys = { ';', ',', 't', 'f', 'T', 'F', ']', '[', ']d', '[d' }, -- Uncomment this to lazy load
    -- ft = 'tex',                                                    -- ...and this if you use LaTeX
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-treesitter/nvim-treesitter-textobjects",
        "folke/flash.nvim"
    },
    opts = {},

    config = function()
        require("demicolon").setup({
            keymaps = {
                horizontal_motions = false,
            },
        })

        local flash_char = require("flash.plugins.char")
        ---@param options { key: string, fowrard: boolean }
        local function flash_jump(options)
            return function()
                require("demicolon.jump").repeatably_do(function(o)
                    local key = o.forward and o.key:lower() or o.key:upper()

                    flash_char.jumping = true
                    local autohide = require("flash.config").get("char").autohide

                    -- Originally was
                    -- if require("flash.repeat").is_repeat then
                    if o.repeated then
                        flash_char.jump_labels = false

                        -- Originally was
                        -- flash_char.state:jump({ count = vim.v.count1 })
                        if o.forward then
                            flash_char.right()
                        else
                            flash_char.left()
                        end

                        flash_char.state:show()
                    else
                        flash_char.jump(key)
                    end

                    vim.schedule(function()
                        flash_char.jumping = false
                        if flash_char.state and autohide then
                            flash_char.state:hide()
                        end
                    end)
                end, options)
            end
        end

        vim.api.nvim_create_autocmd({ "BufLeave", "CursorMoved", "InsertEnter" }, {
            group = vim.api.nvim_create_augroup("flash_char", { clear = true }),
            callback = function(event)
                local hide = event.event == "InsertEnter" or not flash_char.jumping
                if hide and flash_char.state then
                    flash_char.state:hide()
                end
            end,
        })

        vim.on_key(function(key)
            if
                flash_char.state
                and key == require("flash.util").ESC
                and (vim.fn.mode() == "n" or vim.fn.mode() == "v")
            then
                flash_char.state:hide()
            end
        end)

        vim.keymap.set({ "n", "x", "o" }, "f", flash_jump({ key = "f", forward = true }), { desc = "Flash f" })
        vim.keymap.set({ "n", "x", "o" }, "F", flash_jump({ key = "F", forward = false }), { desc = "Flash F" })
        vim.keymap.set({ "n", "x", "o" }, "t", flash_jump({ key = "t", forward = true }), { desc = "Flash t" })
        vim.keymap.set({ "n", "x", "o" }, "T", flash_jump({ key = "T", forward = false }), { desc = "Flash T" })
        vim.keymap.set({ "n", "x", "o" }, "gj", go_wrap(true), { desc = "Display lines downward" })
        vim.keymap.set({ "n", "x", "o" }, "gk", go_wrap(false), { desc = "Display lines upward" })
        vim.keymap.set({ "n", "x", "o" }, "g;", go_change_list(true), { desc = "Go to newer position in change list" })
        vim.keymap.set({ "n", "x", "o" }, "g,", go_change_list(false), { desc = "Go to older position in change list" })
    end,
}
