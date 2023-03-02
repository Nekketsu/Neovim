return {
    -- Color scheme
    {
        'folke/tokyonight.nvim',
        lazy = false,
        opts = {
            style = "night",    -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
            transparent = true, -- Enable this to disable setting the background color
            styles = {
                -- Style to be applied to different syntax groups
                -- Value is any valid attr-list value `:help attr-list`
                comments = "NONE",
                keywords = "NONE",
                functions = "NONE",
                variables = "NONE",
            },
            -- on_highlights = function(highlights, colors)
            --     highlights.CursorLineNr = {
            --         -- fg = "#af00af"
            --         -- fg = colors.fg,
            --         -- fg = colors.black,
            --         -- bg = colors.blue
            --         fg = colors.white
            --         -- fg = "#b1a6f7"
            --     }
            --     highlights.LineNr = {
            --         -- fg = "#b1a6f7"
            --         fg =  colors.blue
            --         -- fg = colors.fg
            --     }
            -- end,
        },
        -- config = function()
        --     vim.cmd [[colorscheme tokyonight-night]]
        -- end
    },
    'mofiqul/vscode.nvim',
    'rebelot/kanagawa.nvim',
    { "catppuccin/nvim", name = "catppuccin" },

    'lunarvim/lunar.nvim',
    'lunarvim/darkplus.nvim',
    'mofiqul/dracula.nvim',
    {
        'nyngwang/nvimgelion',
        config = function()
            -- do whatever you want for further customization~
        end
    },

    {
        "bluz71/vim-moonfly-colors",
        name = "moonfly"
    },

    -- {
    --     'norcalli/nvim-colorizer.lua',
    --     config = true
    -- },

    {
        "NvChad/nvim-colorizer.lua",
        opts = {
            -- user_default_options = {
            --     mode = "virtualtext"
            -- }
        }
    },

    -- {
    --     "brenoprata10/nvim-highlight-colors",
    --     config = true
    -- },

    {
        'bekaboo/dropbar.nvim',
    },

    'hiphish/rainbow-delimiters.nvim',
    {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            local highlight = {
                'RainbowDelimiterBlue',
                'RainbowDelimiterViolet',
                'RainbowDelimiterYellow',
            }
            vim.g.rainbow_delimiters = { highlight = highlight }
            require("ibl").setup {
                indent = {
                    highlight = highlight
                },
                exclude = { filetypes = { "dashboard" } }
            }

            local hooks = require "ibl.hooks"
            hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
        end,
        dependencies = {
            'hiphish/rainbow-delimiters.nvim',
        }
    },

    {
        "luckasRanarison/clear-action.nvim",
        opts = {
            signs = {
                show_label = true
            }
        }
    },

    {
        "anuvyklack/windows.nvim",
        dependencies = {
            "anuvyklack/middleclass",
            -- "anuvyklack/animation.nvim"
        },
        config = function()
            -- vim.o.winwidth = 10
            -- vim.o.winminwidth = 10
            -- vim.o.equalalways = false
            require('windows').setup()
        end,
        keys = {
            { '<C-w>z', '<Cmd>WindowsMaximize<CR>' },
            { '<C-w>_', '<Cmd>WindowsMaximizeVertically<CR>' },
            { '<C-w>|', '<Cmd>WindowsMaximizeHorizontally<CR>' },
            { '<C-w>=', '<Cmd>WindowsEqualize<CR>' }
        }
    },

    {
        'folke/twilight.nvim',
        config = true
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = true
    },

    {
        'folke/zen-mode.nvim',
        config = function()
            require("zen-mode").setup({
                window = {
                    options = {
                        signcolumn = "no", -- disable signcolumn
                        number = false, -- disable number column
                        -- relativenumber = false, -- disable relative numbers
                        -- cursorline = false, -- disable cursorline
                        -- cursorcolumn = false, -- disable cursor column
                        foldcolumn = "0", -- disable fold column
                        -- list = false, -- disable whitespace characters
                    }
                },
                plugins = {
                    options = {
                        enabled = true,
                        ruler = false, -- disables the ruler text in the cmd line area
                        showcmd = false, -- disables the command in the last line of the screen
                        -- you may turn on/off statusline in zen mode by setting 'laststatus' 
                        -- statusline will be shown only if 'laststatus' == 3
                        laststatus = 0, -- turn off the statusline in zen mode
                    },
                },
                on_open = function()
                    vim.cmd("IBLDisable")
                    vim.cmd("SatelliteDisable")
                end,
                on_close = function()
                    vim.cmd("SatelliteEnable")
                    vim.cmd("IBLEnable")
                end,
            })

            vim.keymap.set("n", "<leader>zz", "<Cmd>lua require('zen-mode').toggle()<CR>", { desc = "Zen Mode" })
        end
    },

    "stevearc/dressing.nvim",

    {
        "smjonas/live-command.nvim",
        -- live-command supports semantic versioning via tags
        -- tag = "1.*",
        config = function()
            require("live-command").setup {
                commands = {
                    Norm = { cmd = "norm" },
                    S = { cmd = "Subvert" }
                },
            }
        end
    },

    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set('n', '<leader><F5>', vim.cmd.UndotreeToggle)
        end
    },

    {
        "folke/neodev.nvim",
        opts = {
            library = { plugins = { "neotest", "nvim-dap-ui" }, types = true }
        },
    },

    -- LSP and completion
    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig"
    },

    -- {
    --     'Wansmer/symbol-usage.nvim',
    --     event = 'LspAttach', -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
    --     config = function()
    --         require('symbol-usage').setup()
    --     end
    -- },


    "Hoffs/omnisharp-extended-lsp.nvim",

    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            require("lsp_lines").setup()
            vim.diagnostic.config({ virtual_lines = false, virtual_text = true })
        end,
        keys = {
            {
                "yoe",
                function ()
                    vim.diagnostic.config({
                        virtual_text = not require('lsp_lines').toggle()
                    })
                end,
                desc = "Toggle lsp_lines" },
            { "[oe",
                function ()
                    vim.diagnostic.config({ virtual_lines = true, virtual_text = false })
                end,
                desc = "Enable lsp_lines" },
            {
                "]oe",
                function ()
                    vim.diagnostic.config({ virtual_lines = false, virtual_text = false })
                end,
                desc = "Disable lsp_lines" },
        },
    },

    {
        "soulis-1256/eagle.nvim",
        config = function()
            require("eagle").setup({})
        end
    },

    {
        'LukasPietzschmann/boo.nvim',
        opts = {
            -- here goes your config :)
        },
    },

    {
        'theHamsta/nvim-dap-virtual-text',
        config = true,
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-treesitter/nvim-treesitter"
        }
    },
    {
        'nvim-telescope/telescope-dap.nvim',
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-telescope/telescope.nvim",
            "nvim-treesitter/nvim-treesitter"
        }
    },
    -- {
    --     'Pocco81/dap-buddy.nvim',
    --     config = function()
    --         require('telescope').load_extension('dap')
    --     end
    -- },

    {
        'leoluz/nvim-dap-go',
        config = true
    },

    -- 'vim-test/vim-test',

    -- use({
    --     "andythigpen/nvim-coverage",
    --     dependencies = "nvim-lua/plenary.nvim",
    --     config = function()
    --         require("user.coverage")
    --     end,
    -- })

    'rafamadriz/friendly-snippets',

    'RRethy/vim-illuminate',

    -- use 'arkav/lualine-lsp-progress'

    'onsails/lspkind-nvim',

    {
        'simrat39/symbols-outline.nvim',
        config = function()
            require("symbols-outline").setup()
            vim.keymap.set('n', '<Leader>so', '<cmd>SymbolsOutline<CR>')
        end
    },

    {
        'stevearc/aerial.nvim',
        opts = {
            backends = { "lsp", "treesitter", "markdown", "man" },
            filter_kind = false,
        },
        -- Optional dependencies
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
            {
                "stevearc/stickybuf.nvim",
                opts = { }
            }
        },
        -- config = function()
        --     require('aerial').setup({
        --         -- optionally use on_attach to set keymaps when aerial has attached to a buffer
        --         -- on_attach = function(bufnr)
        --         --     -- Jump forwards/backwards with '{' and '}'
        --         --     vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', {buffer = bufnr})
        --         --     vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', {buffer = bufnr})
        --         -- end,
        --         backends = { "lsp", "treesitter", "markdown", "man" },
        --         filter_kind = false,
        --         preview = true
        --     })
        --     -- You probably also want to set a keymap to toggle aerial
        --     -- vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>')
        -- end,
        keys = {
            { "<leader>a", "<cmd>AerialToggle<cr>", desc = "Aerial (Symbols)" },
        },
    },


    { 'kevinhwang91/nvim-bqf' },

    -- Fugitive for Git
    {
        'tpope/vim-fugitive',
        config = function()
            vim.keymap.set('n', '<Leader>gs', '<cmd>Git<CR>', { noremap = true, silent = true })   -- Git status
            vim.keymap.set('n', '<Leader>gl', '<cmd>Gclog<CR>', { noremap = true, silent = true }) -- Git log
        end
    },
    'tpope/vim-rhubarb',

    {
        "rbong/vim-flog",
        lazy = true,
        cmd = { "Flog", "Flogsplit", "Floggit" },
        dependencies = {
            "tpope/vim-fugitive",
        },
    },

    {
        'sindrets/diffview.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        config = function()
            vim.keymap.set('n', '<leader>gd', '<cmd>DiffviewOpen<CR>', { noremap = true, silent = true })
        end
    },
    -- { 'f-person/git-blame.nvim' },

    'tpope/vim-abolish',
    -- 'tpope/vim-surround',
    -- use 'tpope/vim-commentary'
    -- 'tpope/vim-unimpaired',
    'tpope/vim-repeat',
    'tpope/vim-characterize',
    'tpope/vim-rsi',

    {
        'numToStr/Comment.nvim',
        lazy = false,
        config = function()
            require('Comment').setup {
                pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
            }
        end,
        dependencies = "JoosepAlviste/nvim-ts-context-commentstring"
    },

    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },

    {
        'kristijanhusak/vim-dadbod-ui',
        dependencies = {
            { 'tpope/vim-dadbod',                     lazy = true },
            { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
        },
        cmd = {
            'DBUI',
            'DBUIToggle',
            'DBUIAddConnection',
            'DBUIFindBuffer',
        },
        init = function()
            -- Your DBUI configuration
            vim.g.db_ui_use_nerd_fonts = 1
            vim.cmd [[
                autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
                ]]
        end,
    },

    -- {
    --     "kndndrj/nvim-dbee",
    --     dependencies = {
    --         "MunifTanjim/nui.nvim",
    --     },
    --     build = function()
    --         -- Install tries to automatically detect the install method.
    --         -- if it fails, try calling it with one of these parameters:
    --         --    "curl", "wget", "bitsadmin", "go"
    --         require("dbee").install("go")
    --     end,
    --     config = function()
    --         require("dbee").setup({
    --             sources = {
    --                 name = "Chinook",
    --                 type = "sqlite",
    --                 url = "D:\\Users\\Nekketsu\\Downloads\\chinook\\chinook.db"
    --             }
    --         })
    --     end,
    -- },
    -- {
    --     'liangxianzhe/nap.nvim',
    --     config = function()
    --         local nap = require("nap")
    --         nap.setup({
    --             next_prefix = "]",
    --             prev_prefix = "[",
    --             next_repeat = "<c-n>",
    --             prev_repeat = "<c-p>",
    --             -- next_repeat = ";",
    --             -- prev_repeat = ",",
    --         })
    --         --
    --         -- local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
    --         -- local next_hunk_repeat, prev_hunk_repeat = ts_repeat_move.make_repeatable_move_pair(nap.repeat_last_next, nap.repeat_last_prev)
    --         --
    --         -- vim.keymap.set({ "n", "x", "o" }, "<c-n>", next_hunk_repeat)
    --         -- vim.keymap.set({ "n", "x", "o" }, "<c-p>", prev_hunk_repeat)
    --     end,
    --     dependencies = {
    --         'tpope/vim-unimpaired',
    --     }
    -- },

    'tommcdo/vim-exchange',
    'tommcdo/vim-lion',

    {
        "chrisgrieser/nvim-various-textobjs",
        opts = {
        },
        config = function()
            require("various-textobjs").setup({
                useDefaultKeymaps = true,
                disabledKeymaps = { "gc" },
            })
            vim.keymap.set(
                { "o", "x" },
                "ic",
                "<cmd>lua require('various-textobjs').multiCommentedLines()<CR>",
                { desc = "multiCommentedLines textObj" }
            )
            vim.keymap.set(
                { "o", "x" },
                "ac",
                "<cmd>lua require('various-textobjs').multiCommentedLines()<CR>",
                { desc = "multiCommentedLines textObj" }
            )
        end
    },

    {
        'kana/vim-textobj-entire',
        dependencies = {
            'kana/vim-textobj-user'
        }
    },

    'terryma/vim-expand-region',

    'bronson/vim-visual-star-search',

    {
        'nvim-treesitter/nvim-treesitter-context',
        opts = { enable = true }
    },

    {
        "jcdickinson/wpm.nvim",
        config = true
    },
    {
        "windwp/nvim-autopairs",
        config = true
    },
    {
        "windwp/nvim-ts-autotag",
        config = true
    },


    -- {
    --     "karb94/neoscroll.nvim",
    --     config = true
    -- },

    {
        'akinsho/toggleterm.nvim',
        version = "*",
        config = function()
            local powershell_options = {
                shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell",
                shellcmdflag =
                "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
                shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
                shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
                shellquote = "",
                shellxquote = "",
            }

            for option, value in pairs(powershell_options) do
                vim.opt[option] = value
            end

            require("toggleterm").setup {
                open_mapping = [[<c-\>]],
                insert_mappings = false,
                terminal_mappings = false,
            }
        end
    },

   {
        'rasulomaroff/reactive.nvim',
        config = function()
            require('reactive').setup {
                builtin = {
                    cursorline = true,
                    cursor = true,
                    modemsg = true
                }
            }
        end
    }
    --
    -- {
    --     'glepnir/dashboard-nvim',
    --     event = 'VimEnter',
    --     config = function()
    --         require('dashboard').setup {
    --             theme = "hyper"
    --         }
    --     end,
    --     dependencies = { {'nvim-tree/nvim-web-devicons'}}
    -- }
}
