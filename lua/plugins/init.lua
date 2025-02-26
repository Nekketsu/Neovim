return {
    -- Color scheme
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        opts = {
            style = "night",    -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
            transparent = true, -- Enable this to disable setting the background color
            styles = {
                -- Style to be applied to different syntax groups
                -- Value is any valid attr-list value `:help attr-list`
                comments = { italic = false },
                keywords = { italic = false },
            },
        },
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
        'Chaitanyabsprip/fastaction.nvim',
        ---@type FastActionConfig
        opts = {},
        keys = {
            {
                "<leader>ca",
                function() require("fastaction").code_action() end,
                desc = "Fast action",
            },
        },
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

    -- LSP and completion
    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        config = function()
            require("mason").setup()
---@diagnostic disable-next-line: missing-fields
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "asm_lsp", "clangd", "codelldb", "cpptools", "css-lsp", "csharpier", "debugpy", "gopls",
                    "html-lsp", "json-lsp", "lua-language-server", "netcoredbg", "pyright",
                    "roslyn", "rust-analyzer", "rzls", "typescript-language-server"
                }
            })
        end
    },

    {
        'Wansmer/symbol-usage.nvim',
        event = 'BufReadPre', -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
        opts = {
            references = { enabled = true, include_declaration = true },
            definition = { enabled = true },
            implementation = { enabled = true },
            vt_position = "end_of_line"
        },
        config = function()
            local function h(name) return vim.api.nvim_get_hl(0, { name = name }) end

            -- hl-groups can have any name
            vim.api.nvim_set_hl(0, 'SymbolUsageRounding', { fg = h('CursorLine').bg, italic = true })
            vim.api.nvim_set_hl(0, 'SymbolUsageContent', { bg = h('CursorLine').bg, fg = h('Comment').fg, italic = true })
            vim.api.nvim_set_hl(0, 'SymbolUsageRef', { fg = h('Function').fg, bg = h('CursorLine').bg, italic = true })
            vim.api.nvim_set_hl(0, 'SymbolUsageDef', { fg = h('Type').fg, bg = h('CursorLine').bg, italic = true })
            vim.api.nvim_set_hl(0, 'SymbolUsageImpl', { fg = h('@keyword').fg, bg = h('CursorLine').bg, italic = true })

            local function text_format(symbol)
                local res = {}

                local round_start = { '', 'SymbolUsageRounding' }
                local round_end = { '', 'SymbolUsageRounding' }

                -- Indicator that shows if there are any other symbols in the same line
                local stacked_functions_content = symbol.stacked_count > 0
                and ("+%s"):format(symbol.stacked_count)
                or ''

                if symbol.references then
                    local usage = symbol.references <= 1 and 'usage' or 'usages'
                    local num = symbol.references == 0 and 'no' or symbol.references
                    table.insert(res, round_start)
                    table.insert(res, { '󰌹 ', 'SymbolUsageRef' })
                    table.insert(res, { ('%s %s'):format(num, usage), 'SymbolUsageContent' })
                    table.insert(res, round_end)
                end

                if symbol.definition then
                    if #res > 0 then
                        table.insert(res, { ' ', 'NonText' })
                    end
                    table.insert(res, round_start)
                    table.insert(res, { '󰳽 ', 'SymbolUsageDef' })
                    table.insert(res, { symbol.definition .. ' defs', 'SymbolUsageContent' })
                    table.insert(res, round_end)
                end

                if symbol.implementation then
                    if #res > 0 then
                        table.insert(res, { ' ', 'NonText' })
                    end
                    table.insert(res, round_start)
                    table.insert(res, { '󰡱 ', 'SymbolUsageImpl' })
                    table.insert(res, { symbol.implementation .. ' impls', 'SymbolUsageContent' })
                    table.insert(res, round_end)
                end

                if stacked_functions_content ~= '' then
                    if #res > 0 then
                        table.insert(res, { ' ', 'NonText' })
                    end
                    table.insert(res, round_start)
                    table.insert(res, { ' ', 'SymbolUsageImpl' })
                    table.insert(res, { stacked_functions_content, 'SymbolUsageContent' })
                    table.insert(res, round_end)
                end

                return res
            end

---@diagnostic disable-next-line: missing-fields
            require('symbol-usage').setup({
                vt_position = "end_of_line",
                references = { enabled = true, include_declaration = true },
                definition = { enabled = true },
                implementation = { enabled = true },
                text_format = text_format,
            })
        end
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

    {
        'leoluz/nvim-dap-go',
        config = true
    },

    'rafamadriz/friendly-snippets',

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


    {
        'kevinhwang91/nvim-bqf',
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
                { ">", "<cmd>lua require('quicker').expand()<CR>", desc = "Expand quickfix content" },
                { "<", "<cmd>lua require('quicker').collapse()<CR>", desc = "Collapse quickfix content" },
            },
            highlight = {
                load_buffers = false
            }
        },
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
        'sindrets/diffview.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        opts = {
            keymaps = {
                file_panel = {
                    ["q"] = "<cmd>DiffviewClose<cr>"
                }
            }
        },
        keys = {
            {'<leader>gd', '<cmd>DiffviewOpen<CR>', desc = "Git diffview"}
        }
    },
    
    {
        "abccsss/nvim-gitstatus",
        event = "VeryLazy",
        config = true,
    },

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

    'tpope/vim-abolish',
    -- 'tpope/vim-unimpaired',
    'tpope/vim-repeat',
    'tpope/vim-characterize',
    'tpope/vim-rsi',

    -- {
    --     'assistcontrol/readline.nvim',
    --     keys = {
    --         { '<C-k>', function() require("readline").kill_line() end, mode = "!", desc = "Kill line" },
    --         { '<C-u>', function() require("readline").backward_kill_line() end, mode = "!", desc = "Backdward kill line" },
    --         { '<M-d>', function() require("readline").kill_word() end, mode = "!", desc = "Kill word" },
    --         { '<M-BS>', function() require("readline").backward_kill_word() end, mode = "!", desc = "Backward kill word" },
    --         { '<C-w>', function() require("readline").unix_word_rubout() end, mode = "!", desc = "Unix word rubout" },
    --         { '<C-d>', '<Delete>' , mode = "!", desc = "Delete char" },
    --         { '<C-h>', '<BS>', mode = "!", desc = "Backward delete char" },
    --         { '<C-a>', function() require("readline").beginning_of_line() end, mode = "!", desc = "Beginning of line" },
    --         { '<C-e>', function() require("readline").end_of_line() end, mode = "!", desc = "End of line" },
    --         { '<M-f>', function() require("readline").forward_word() end, mode = "!", desc = "Forward word" },
    --         { '<M-b>', function() require("readline").backward_word() end, mode = "!", desc = "Backward word" },
    --         { '<C-f>', '<Right>', mode = "!", desc = "Forward char" },
    --         { '<C-b>', '<Left>', mode = "!", desc = "Backward char" },
    --         { '<C-n>', '<Down>', mode = "!", desc = "Next line" },
    --         { '<C-p>', '<Up>', mode = "!", desc = "Previous line" },
    --     }
    -- },

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

    {
        'davesavic/dadbod-ui-yank',
        dependencies = { 'kristijanhusak/vim-dadbod-ui' },
        config = function()
            require('dadbod-ui-yank').setup()
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
                useDefaults = true,
                disabledDefaults = {
                    "ai", "ii", "aI", "iI"
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

    "romainl/vim-cool",

    {
        'MoaidHathot/dotnet.nvim',
        cmd = "DotnetUI",
        opts = {},
    },

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
        ft = "cs",
        opts = {
            -- your configuration comes here; leave empty for default settings
        }
    },

    {
        "OXY2DEV/markview.nvim",
        lazy = false
    },

    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
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
        "nvzone/menu",
        lazy = true,
        dependencies = { "nvzone/volt" , lazy = true },
        keys = {
            { "<C-T>", function() require("menu").open("default") end },
            { "<RightMouse>",
                function()
                    require("menu.utils").delete_old_menus()

                    vim.cmd.exec '"normal! \\<RightMouse>"'

                    local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
                    local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"
                    if vim.bo[buf].ft == "NvimTree" then
                        options = "nvimtree"
                    -- elseif vim.bo[buf].ft == "neo-tree" then
                    --     options = "neotree"
                    -- else
                        -- options = "default"
                    end

                        
                    require("menu").open(options, { mouse = true })
                end,
                mode = { "n", "v" } }
        }
    },
    {
        "nvzone/minty",
        cmd = { "Shades", "Huefy" },
        dependencies = { "nvzone/volt", lazy = true }
    },

    {
        'stevearc/overseer.nvim',
        -- opts = {
        --     templates = {
        --         { "builtin", "user.net_build" }
        --     }
        -- },
        config = function()
            require("overseer").setup({
                templates = { "builtin", "user.net_build" },
            })
        end
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

    {
        "nvzone/typr",
        dependencies = "nvzone/volt",
        opts = {},
        cmd = { "Typr", "TyprStats" },
    }
}
