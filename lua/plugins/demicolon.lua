return {
    "mawkler/demicolon.nvim",
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
                disabled_keys = { 'p', 'I', 'A'--[[, 'f', 'i'--]] }
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

        local function repeatably_do(next, prev)
            return function(forward)
                return function()
                    require("demicolon.jump").repeatably_do(function(opts)
                        local motion = opts.forward ~= false and next or prev
                        vim.cmd(string.format("normal! %s%s", vim.v.count, motion))
                    end, { forward = forward })
                end
            end
        end

        local function map_repeatably_do(next, prev, next_desc, prev_desc)
            local repeatably = repeatably_do(next, prev)
            vim.keymap.set({ "n", "x", "o" }, next, repeatably(true), { desc = next_desc, remap = false })
            vim.keymap.set({ "n", "x", "o" }, prev, repeatably(false), { desc = prev_desc, remap = false })
        end


        vim.keymap.set({ "n", "x", "o" }, "f", flash_jump({ key = "f", forward = true }), { desc = "Flash f" })
        vim.keymap.set({ "n", "x", "o" }, "F", flash_jump({ key = "F", forward = false }), { desc = "Flash F" })
        vim.keymap.set({ "n", "x", "o" }, "t", flash_jump({ key = "t", forward = true }), { desc = "Flash t" })
        vim.keymap.set({ "n", "x", "o" }, "T", flash_jump({ key = "T", forward = false }), { desc = "Flash T" })

        map_repeatably_do("gj", "gk", "Display lines downward", "Display lines upward")
        map_repeatably_do("g;", "g,", "Go to newer position in change list", "Go to older position in change list")
        map_repeatably_do("gt", "gT", "Go to the next tab page", "Go to the previous tab page")
    end,
}
