return {
    -- Color scheme
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        -- opts = {
        --     style = "night",    -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
        --     transparent = true, -- Enable this to disable setting the background color
        --     styles = {
        --         -- Style to be applied to different syntax groups
        --         -- Value is any valid attr-list value `:help attr-list`
        --         comments = { italic = false },
        --         keywords = { italic = false },
        --     },
        -- },
        config = function()
            require("tokyonight").setup({
                style = "night",
                transparent = true,
                styles = {
                    comments = { italic = false },
                    keywords = { italic = false },
                },
                on_highlights = function(hl, c)
                    hl.DiagnosticUnderlineInfo = {
                        sp = "#1abc9c",
                        -- sp = "#ffcc66"
                        underdotted = true,
                    }
                    hl.DiagnosticUnderlineHint = {
                        sp = "#0db9d7",
                        -- sp = "#4bc1fe"
                        underdotted = true,
                    }
                end
            })

            vim.o.termguicolors = true
            vim.cmd([[colorscheme tokyonight]])
        end
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
    'shaunsingh/nord.nvim',
    {
        "mcauley-penney/techbase.nvim",
        -- config = function(_, opts)
        --     vim.cmd.colorscheme("techbase")
        -- end,
        priority = 1000
    },

    {
        'norcalli/nvim-colorizer.lua',
        config = true
    },

    {
        'bekaboo/dropbar.nvim',
    },

    {
        'hiphish/rainbow-delimiters.nvim',
        config = function()
            require("rainbow-delimiters.setup").setup({
                highlight = {
                    "RainbowDelimiterBlue",
                    "RainbowDelimiterViolet",
                    "RainbowDelimiterYellow"
                }
            })
        end
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
        "soulis-1256/eagle.nvim",
        config = function()
            require("eagle").setup({})
        end
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
        'leoluz/nvim-dap-go',
        config = true
    },

    {
        'stevearc/aerial.nvim',
        opts = {
            on_attach = function(bufnr)
                vim.keymap.set('n', '[<C-s>', '<cmd>AerialPrev<CR>', {buffer = bufnr, desc = "Aerial next"})
                vim.keymap.set('n', ']<C-s>', '<cmd>AerialNext<CR>', {buffer = bufnr, desc = "Aerial previous"})
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

    {
        'kevinhwang91/nvim-bqf',
        ft = "qf",
        dependencies = {
            "junegunn/fzf",
            build = function() vim.fn["fzf#install"]() end,
        },
        opts = {
            func_map = {
                prevhist = "g<",
                nexthist = "g>"
            }
        },
    },

    {
        'stevearc/quicker.nvim',
        event = "FileType qf",
        ---@module "quicker"
        ---@type quicker.SetupOptions
        opts = {
            keys = {
                { ">>", function() require("quicker").expand({ before = 2, after = 2, add_to_existing = true }) end, desc = "Expand quickfix context" },
                { "<<", function() require("quicker").collapse() end, desc = "Collapse quickfix context" },
            },
            highlight = {
                load_buffers = false
            }
        },
        init = function()
            vim.keymap.set("n",  "<leader>Q", function() require("quicker").toggle() end, { desc = "Toggle quickfix" })
            vim.keymap.set("n",  "<leader>L", function() require("quicker").toggle({ loclist = true }) end, { desc = "Toggle loclist" })

            vim.keymap.set("n",  "yoQ", function() require("quicker").toggle() end, { desc = "Toggle quickfix" })
            vim.keymap.set("n",  "[oQ", function() require("quicker").open() end, { desc = "Open quickfix" })
            vim.keymap.set("n",  "]oQ", function() require("quicker").close() end, { desc = "Close quickfix" })
            vim.keymap.set("n",  "yoL", function() require("quicker").toggle({ loclist = true }) end, { desc = "Toggle loclist" })
            vim.keymap.set("n",  "[oL", function() require("quicker").open({ loclist = true }) end, { desc = "Toggle loclist" })
            vim.keymap.set("n",  "]oL", function() require("quicker").close({ loclist = true }) end, { desc = "Toggle loclist" })
        end
    },

    -- Fugitive for Git
    {
        'tpope/vim-fugitive',
        keys = {
            {'<Leader>gs', '<cmd>Git<CR>', desc = "Git status"},
            -- {'<Leader>gl', '<cmd>Gclog<CR>', desc = "git log"}
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
        "esmuellert/codediff.nvim",
        cmd = "CodeDiff",
        keys = {
            { "<leader>gd", vim.cmd.CodeDiff, desc = "CodeDiff" } 
        }
    },

    {
        "pwntester/octo.nvim",
        cmd = "Octo",
        opts = {
            -- or "fzf-lua" or "snacks" or "default"
            picker = "snacks",
            -- bare Octo command opens picker of commands
            enable_builtin = true,
        },
        keys = {
            {
                "<leader>Oi",
                "<CMD>Octo issue list<CR>",
                desc = "List GitHub Issues",
            },
            {
                "<leader>Op",
                "<CMD>Octo pr list<CR>",
                desc = "List GitHub PullRequests",
            },
            {
                "<leader>Omp",
                "<CMD>Octo pr search author:@me is:open<CR>",
                desc = "List GitHub PullRequests (mine open)",
            },
            {
                "<leader>Od",
                "<CMD>Octo discussion list<CR>",
                desc = "List GitHub Discussions",
            },
            {
                "<leader>On",
                "<CMD>Octo notification list<CR>",
                desc = "List GitHub Notifications",
            },
            {
                "<leader>Os",
                function()
                    require("octo.utils").create_base_search_command { include_current_repo = true }
                end,
                desc = "Search GitHub",
            },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            -- "nvim-telescope/telescope.nvim",
            -- OR "ibhagwan/fzf-lua",
            -- OR "folke/snacks.nvim",
            "folke/snacks.nvim",
            "nvim-tree/nvim-web-devicons",
        },
    },


    {
        "abccsss/nvim-gitstatus",
        event = "VeryLazy",
        config = true,
    },

    'tpope/vim-abolish',
    -- 'tpope/vim-unimpaired',
    'tpope/vim-repeat',
    'tpope/vim-characterize',
    -- 'tpope/vim-rsi',

    {
        "assistcontrol/readline.nvim",
        config = function()
            local readline = require 'readline'
            vim.keymap.set('!', '<C-k>', readline.kill_line, { desc = "Kill line" })
            vim.keymap.set('!', '<C-u>', readline.backward_kill_line, { desc = "Backward kill line" })
            vim.keymap.set('!', '<M-d>', readline.kill_word, { desc = "Kill word" })
            vim.keymap.set('!', '<M-BS>', readline.unix_word_rubout, { desc = "Unix word rubout" })
            vim.keymap.set('!', '<C-w>', readline.backward_kill_word, { desc = "Backward kill word" })
            vim.keymap.set('!', '<C-d>', '<Delete>', { desc = "Delete char" })
            vim.keymap.set('!', '<C-h>', '<BS>', { desc = "Backward delete char" })
            vim.keymap.set('!', '<C-a>', readline.beginning_of_line, { desc = "Beginning of line" })
            vim.keymap.set('!', '<C-e>', readline.end_of_line, { desc = "End of line" })
            vim.keymap.set('!', '<M-f>', readline.forward_word, { desc = "Forward word" })
            vim.keymap.set('!', '<M-b>', readline.backward_word, { desc = "Backward word" })
            vim.keymap.set('!', '<C-f>', '<Right>', { desc = "Forward char" })
            vim.keymap.set('!', '<C-b>', '<Left>', { desc = "Backward char" })
            vim.keymap.set('!', '<C-n>', '<Down>', { desc = "Next line" })
            vim.keymap.set('!', '<C-p>', '<Up>', { desc = "Previous line" })
        end,
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
            { 'tpope/vim-dadbod', lazy = true },
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
        end,
    },

    {
        'davesavic/dadbod-ui-yank',
        dependencies = { 'kristijanhusak/vim-dadbod-ui' },
        config = function()
            require('dadbod-ui-yank').setup()
        end,
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
                useDefaults = true,
                disabledDefaults = {
                    "ai", "ii", "aI", "iI", "an", "in"
                }
            }
        },
    },

    {
        'kana/vim-textobj-entire',
        dependencies = {
            'kana/vim-textobj-user'
        }
    },

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

    "andersevenrud/nvim_context_vt",

    {
        "windwp/nvim-autopairs",
        opts = {
            fast_wrap = {}
        },
        init = function ()
            local Rule = require('nvim-autopairs.rule')
            local npairs = require('nvim-autopairs')

            npairs.add_rules({
                Rule("$", "$", "typst")
                :with_pair(function(opts)
                    return opts.line:sub(opts.col, opts.col) ~= "$"
                end)
                :with_move(function(opts)
                    return opts.next_char == "$"
                end)
                :use_key("$")
            })
        end
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

    "romainl/vim-cool",

    {
        "chentoast/marks.nvim",
        event = "VeryLazy",
        opts = {}
    },

    {
        "sphamba/smear-cursor.nvim",
        opts = {},
    },

    {
        "seblyng/roslyn.nvim",
        ft = { "cs", "razor" },
        lazy = false,
        opts = {

        },
        init = function()
            vim.filetype.add({
                extension = {
                    razor = "razor",
                    cshtml = "razor",
                    xaml = "xml"
                }
            })
        end
    },

    -- {
    --     "iamcco/markdown-preview.nvim",
    --     cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    --     ft = { "markdown" },
    --     build = function() vim.fn["mkdp#util#install"]() end,
    -- },

    {
        "toppair/peek.nvim",
        event = { "VeryLazy" },
        build = "deno task --quiet build:fast",
        config = function()
            require("peek").setup({
                app = "browser"
            })
            vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
            vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
        end,
    },

    {
        'MeanderingProgrammer/render-markdown.nvim',
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    },

    {
        "sylvanfranklin/omni-preview.nvim",
        opts = {},
        keys = {
            { "<leader>po", "<cmd>OmniPreview start<CR>", desc = "OmniPreview Start" },
            { "<leader>pc", "<cmd>OmniPreview stop<CR>",  desc = "OmniPreview Stop" },
        }
    },

    {
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        opts = {
            -- add any custom options here
        },
        keys = {
            { "<leader>qs", function() require("persistence").load() end, desc = "Persistence load" },
            { "<leader>qS", function() require("persistence").select() end, desc = "Persistence select" },
            { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Persistence load last" },
            { "<leader>qd", function() require("persistence").stop() end, desc = "Persistence stop" }
        }
    },

    {
        'MagicDuck/grug-far.nvim',
        config = function()
            require('grug-far').setup({
                -- options, see Configuration section below
                -- there are no required options atm
                -- engine = 'ripgrep' is default, but 'astgrep' can be specified
            });
        end,
        keys = {
            {
                "<leader>sr",
                function() require("grug-far").open() end,
                mode = { "n", "v" },
                desc = "Search and Replace",
            },
        },
    },
}
