return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        lazy = false, -- neo-tree lazy-loads itself; see the note below
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
            "alessandropietrobelli/dotnet-tree.nvim",
        },
        opts = function(_, opts)
            opts.default_component_configs = vim.tbl_deep_extend("force", opts.default_component_configs or {}, {
                indent = {
                    with_expanders = true, -- Asegura que los expanders funcionen globalmente
                },
            })

            local cwd = vim.fn.getcwd()
            local has_sln = #vim.fn.globpath(cwd, "*.sln", false, true) > 0
                or #vim.fn.globpath(cwd, "*.slnx", false, true) > 0
            if not has_sln then
                return
            end

            opts.sources = opts.sources or { "filesystem", "buffers", "git_status", "document_symbols" }
            if not vim.tbl_contains(opts.sources, "dotnet-tree") then
                table.insert(opts.sources, "dotnet-tree")
            end
            opts.default_source = "dotnet-tree"

            opts.source_selector = opts.source_selector or {}
            opts.source_selector.winbar = opts.source_selector.winbar ~= false
            opts.source_selector.sources = {
                { source = "dotnet-tree", display_name = " 󰘐 .NET" },
                { source = "filesystem", display_name = "  Files" },
                { source = "git_status", "Git Changes" }
            }
        end,
        keys = {
            -- { "<leader>fd", "<cmd>Neotree dotnet-tree reveal<cr>", desc = "Dotnet solution explorer" },
            { "<leader>fd", "<cmd>Neotree reveal<cr>", desc = "Neotree" },
        }
    },
    {
        "alessandropietrobelli/dotnet-counters.nvim",
        -- Load early (setup is cheap) so it can hook into nvim-dap before the first session
        event = "VeryLazy",
        cmd = "DotnetCounters",
        opts = {},
        keys = {
            { "<leader>dm", "<cmd>DotnetCounters toggle<cr>", desc = ".NET metrics panel" },
            { "<leader>dM", "<cmd>DotnetCounters attach<cr>", desc = ".NET metrics: attach to process" },
        },
    },
    {
        "alessandropietrobelli/nuget.nvim",
        -- Startup only defines :Nuget; everything else loads when the window opens. Loading it
        -- lazily would also hide :checkhealth nuget until the first :Nuget.
        lazy = false,
        opts = {},
        keys = {
            { "<leader>cN", "<cmd>Nuget<cr>",         desc = "NuGet packages" },
            { "<leader>cU", "<cmd>Nuget updates<cr>", desc = "NuGet updates" },
        },
    }
}
