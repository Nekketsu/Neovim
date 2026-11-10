return {
    'saghen/blink.cmp',
    dependencies = {
        'saghen/blink.lib',
        -- optional: provides snippets for the snippet source
        'rafamadriz/friendly-snippets',
    },
    build = function()
        -- build the fuzzy matcher, optionally add a timeout to `pwait(timeout_ms)`
        -- you can use `gb` in `:Lazy` to rebuild the plugin as needed
        require('blink.cmp').build():pwait()
    end,

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        keymap = {
            preset = 'super-tab',
            ["<Tab>"] = {
                -- 1. Primero dejamos que blink intente hacer su lógica de super-tab nativa
                function(cmp)
                    return cmp.select_and_accept()
                end,
                -- 2. Si no hay menú de autocompletado abierto, salta o aplica la sugerencia de Sidekick
                function()
                    return require("sidekick").nes_jump_or_apply()
                end,
                "snippet_forward",
                -- 4. Si nada de lo anterior se cumple, escribe un tabulador normal
                "fallback",
            },
        },

        -- (Default) Only show the documentation popup when manually triggered
        completion = {
            documentation = { auto_show = true }
        },

        signature = {
            enabled = true,
            window = {
                show_documentation = true
            }
        },

        -- (Default) list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        -- sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
            per_filetype = {
                lua = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
                sql = { 'snippets', 'dadbod', 'buffer' },
                org = { inherit_defaults = true, "org" }
            },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    -- make lazydev completions top priority (see `:h blink.cmp`)
                    score_offset = 100,
                },
                org = { name = "Org", module = "org.completion.blink" }
            }
        },

        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"`
        -- See the fuzzy documentation for more information
        fuzzy = { implementation = "rust" }
    },
}
