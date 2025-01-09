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
    "techtuner/aura-neovim",

    -- {
    --     'norcalli/nvim-colorizer.lua',
    --     config = true
    -- },

    {
        "NvChad/nvim-colorizer.lua",
        event = "BufReadPre",
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
                    highlight = highlight,
                    char = '▏'
                },
                exclude = { filetypes = { "dashboard" } },
            }

            local hooks = require "ibl.hooks"
            hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
        end,
        dependencies = {
            'hiphish/rainbow-delimiters.nvim',
        }
    },

    -- {
    --     "luckasRanarison/clear-action.nvim",
    --     config = function()
    --         require("clear-action").setup()
    --     end
    --     -- opts = {
    --     --     signs = {
    --     --         show_label = true
    --     --     }
    --     -- }
    -- },

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
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },

    {
        'folke/zen-mode.nvim',
        opts = {
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
        },
        keys = {
            {"<leader>zz", function() require('zen-mode').toggle() end, desc = "Zen Mode" }
        }
    },

    "stevearc/dressing.nvim",

    {
        "grapp-dev/nui-components.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim"
        }
    },

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
        end,
        keys = {
            {'<leader><F5>', vim.cmd.UndotreeToggle}
        }
    },

    -- {
    --     "folke/neodev.nvim",
    --     opts = {
    --         library = { plugins = { "neotest", "nvim-dap-ui" }, types = true }
    --     },
    -- },

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


    -- "Hoffs/omnisharp-extended-lsp.nvim",

    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            require("lsp_lines").setup()
            vim.diagnostic.config({ virtual_lines = false, virtual_text = { severity = { min = vim.diagnostic.severity.WARN }}})
        end,
        keys = {
            {
                "yoe",
                function ()
                    if require('lsp_lines').toggle() then
                        vim.diagnostic.config({ virtual_lines = true, virtual_text = false })
                    else
                        vim.diagnostic.config({ virtual_lines = false, virtual_text = { severity = { min = vim.diagnostic.severity.WARN }}})
                    end
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
                    vim.diagnostic.config({ virtual_lines = false, virtual_text = { severity = { min = vim.diagnostic.severity.WARN }}})
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
        "hedyhli/outline.nvim",
        lazy = true,
        cmd = { "Outline", "OutlineOpen" },
        keys = { -- Example mapping to toggle outline
            { "<leader>so", "<cmd>Outline<CR>", desc = "Toggle outline" },
        },
        opts = {
            -- Your setup opts here
        },
    },

    {
        'stevearc/aerial.nvim',
        opts = {
            on_attach = function(bufnr)
                -- Jump forwards/backwards with '{' and '}'
                local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
                local next_symbol_repeat, previous_symbol_repeat = ts_repeat_move.make_repeatable_move_pair(function() vim.cmd("AerialNext") end, function() vim.cmd("AerialPrev") end)
                vim.keymap.set('n', ']<C-s>', next_symbol_repeat, {buffer = bufnr})
                vim.keymap.set('n', '[<C-s>', previous_symbol_repeat, {buffer = bufnr})

                -- vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', {buffer = bufnr})
                -- vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', {buffer = bufnr})
            end,
            backends = { "lsp", "treesitter", "markdown", "man" },
            filter_kind = false,
            preview = true,
            show_guides = true
        },
        -- Optional dependencies
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        keys = {
            { "<leader>a", "<cmd>AerialToggle!<CR>", desc = "Aerial (Symbols)" },
        },
    },


    { 'kevinhwang91/nvim-bqf' },

    -- Fugitive for Git
    {
        'tpope/vim-fugitive',
        keys = {
            {'<Leader>gs', '<cmd>Git<CR>', desc = "Git status"},
            {'<Leader>gl', '<cmd>Gclog<CR>', desc = "git log"}
        }
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
        keys = {
            {'<leader>gd', '<cmd>DiffviewOpen<CR>', desc = "Git diffview"}
        }
    },
    -- { 'f-person/git-blame.nvim' },

    'tpope/vim-abolish',
    -- 'tpope/vim-surround',
    -- use 'tpope/vim-commentary'
    -- 'tpope/vim-unimpaired',
    'tpope/vim-repeat',
    'tpope/vim-characterize',
    'tpope/vim-rsi',

    -- {
    --     'numToStr/Comment.nvim',
    --     lazy = false,
    --     config = function()
    --         require('Comment').setup {
    --             pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    --         }
    --     end,
    --     dependencies = "JoosepAlviste/nvim-ts-context-commentstring"
    -- },

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


    -- 'tommcdo/vim-exchange',
    'tommcdo/vim-lion',

    {
        'junegunn/vim-easy-align',
        init = function()
            vim.cmd[[
            " Start interactive EasyAlign in visual mode (e.g. vipga)
            xmap ga <Plug>(EasyAlign)

            " Start interactive EasyAlign for a motion/text object (e.g. gaip)
            nmap ga <Plug>(EasyAlign)
            ]]
        end
    },

    {
        "gbprod/substitute.nvim",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        keys = {
          {"cx", function() require("substitute.exchange").operator() end, desc = "Substitute operator"},
          {"cxx", function() require("substitute.exchange").line() end, desc = "Substitute line"},
          {"X", function() require("substitute.exchange").visual() end, mode = "x", desc = "Substitute visual"},
          {"cxc", function() require("substitute.exchange").cancel() end, desc = "Substitute cancel"},

          {"<leader>cx", function() require("substitute").operator() end, desc = "Substitute operator"},
          {"<leader>cxx", function() require("substitute").line() end, desc = "Substitute line"},
          {"<leader>cX", function() require("substitute").cancel() end, desc = "Substitute cancel"},
          {"<leader>X", function() require("substitute").visual() end, mode = "x", desc = "Substitute visual"},
        }
    },

    {
        "chrisgrieser/nvim-various-textobjs",
        event = "VeryLazy",
        opts = { 
            keymaps = {
                useDefaults = true 
            }
        },
    },

    {
        'kana/vim-textobj-entire',
        dependencies = {
            'kana/vim-textobj-user'
        }
    },

    -- 'terryma/vim-expand-region',

    -- 'bronson/vim-visual-star-search',

    {
        'nvim-treesitter/nvim-treesitter-context',
        opts = { enable = true },
        -- keys = {
        --     { 'yoc', '<Cmd>TSContextToggle<CR>', desc = "Toggle TSContext" },
        --     { '[oc', '<Cmd>TSContextEnable<CR>', desc = "Enable TSContext" },
        --     { ']oc', '<Cmd>TSContextDisable<CR>', desc = "Disable TSContext" },
        -- }
        config = function()
            vim.keymap.set("n", 'yoc', '<Cmd>TSContextToggle<CR>', { desc = "Toggle TSContext" })
            vim.keymap.set("n", '[oc', '<Cmd>TSContextEnable<CR>', { desc = "Enable TSContext" })
            vim.keymap.set("n", ']oc', '<Cmd>TSContextDisable<CR>', { desc = "Disable TSContext" })
        end
    },

    {
        "windwp/nvim-autopairs",
        config = true
    },
    {
        "windwp/nvim-ts-autotag",
        config = true
    },

    {
        'mcauley-penney/visual-whitespace.nvim',
        config = true
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
    },

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

    {
        "romainl/vim-cool"
    },

    {
        'MoaidHathot/dotnet.nvim',
        cmd = "DotnetUI",
        opts = {},
    },

    {
        "chentoast/marks.nvim",
        config = true
    },

    {
        "sphamba/smear-cursor.nvim",
        opts = {},
    },

    -- {
    --     "karb94/neoscroll.nvim",
    --     config = function ()
    --         local neoscroll = require('neoscroll')
    --         neoscroll.setup({
    --             -- Default easing function used in any animation where
    --             -- the `easing` argument has not been explicitly supplied
    --             easing = "quadratic"
    --         })
    --         local keymap = {
    --             -- Use the "sine" easing function
    --             ["<C-u>"] = function() neoscroll.ctrl_u({ duration = 100; easing = 'sine' }) end;
    --             ["<C-d>"] = function() neoscroll.ctrl_d({ duration = 100; easing = 'sine' }) end;
    --             -- Use the "circular" easing function
    --             ["<C-b>"] = function() neoscroll.ctrl_b({ duration = 100; easing = 'circular' }) end;
    --             ["<C-f>"] = function() neoscroll.ctrl_f({ duration = 100; easing = 'circular' }) end;
    --             -- When no value is passed the `easing` option supplied in `setup()` is used
    --             ["<C-y>"] = function() neoscroll.scroll(-0.1, { move_cursor=false; duration = 100 }) end;
    --             ["<C-e>"] = function() neoscroll.scroll(0.1, { move_cursor=false; duration = 100 }) end;
    --         }
    --         local modes = { 'n', 'v', 'x' }
    --         for key, func in pairs(keymap) do
    --             vim.keymap.set(modes, key, func)
    --         end
    --     end
    -- },

    {
        "seblj/roslyn.nvim",
        ft = "cs",
        opts = {
            -- your configuration comes here; leave empty for default settings
        }
    },

    {
        "GustavEikaas/easy-dotnet.nvim",
        dependencies = { "nvim-lua/plenary.nvim", 'nvim-telescope/telescope.nvim', },
        config = function()
            require("easy-dotnet").setup({})
        end
    }
}
