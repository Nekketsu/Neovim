return {
    {
        "refractalize/oil-git-status.nvim",

        dependencies = {
            "stevearc/oil.nvim",
        },

        config = true,
    },

    {
        "JezerM/oil-lsp-diagnostics.nvim",
        dependencies = { "stevearc/oil.nvim" },
        opts = {}
    },
    {
        'stevearc/oil.nvim',
        config = function()
            require("oil").setup({
                keymaps = {
                    ["y."] = "actions.copy_entry_path",
                    ["."] = "actions.open_cmdline",
                    ["<Esc>"] = "actions.close",
                    ["gq"] = "actions.close"
                },
                win_options = {
                    signcolumn = "yes:2"
                }
            })

            local oil = require("oil")
            local file

            local function focus_file(buffer)
                local line_count = vim.api.nvim_buf_line_count(buffer)

                for n = 1, line_count do
                    local entry = oil.get_entry_on_line(buffer, n)
                    if entry and entry.name == file then
                        vim.api.nvim_win_set_cursor(0, { n, 0 })
                        return
                    end
                end
            end

            local function open_oil_focus_file()
                file = vim.fn.expand("%:t")
                oil.open()
            end

            vim.api.nvim_create_autocmd("User", {
                pattern = "OilEnter",
                callback = function(args)
                    local buffer = args.data.buf

                    focus_file(buffer)
                end,
            })

            vim.keymap.set("n", "-", open_oil_focus_file)
        end,
        -- keys = {
            --         {"-", "<cmd>Oil<CR>", desc = "Open parent directory" }
            --     },
            -- Optional dependenciese
            dependencies = "nvim-tree/nvim-web-devicons",
        }
    }
