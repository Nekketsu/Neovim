return {
    'oribarilan/lensline.nvim',
    -- tag = '1.0.0', -- or: branch = 'release/1.x' for latest non-breaking updates
    event = 'LspAttach',
    -- config = function()
    --     require("lensline").setup()
    -- end,
    opts = {
        profiles = {
            {
                name = "above",
                providers = {
                    {
                        name = "usages",
                        enabled = true,
                        include = { "refs", "defs", "impls" },  -- Track all usage types
                        breakdown = true,                       -- Show "5 refs, 2 defs, 1 impls"
                        show_zero = true,
                    },
                    { name = "last_author", enabled = true }
                },
                style = { render = "all", placement = "inline" }
            },
            {
                name = "inline",
                providers = {
                    {
                        name = "usages",
                        enabled = true,
                        include = { "refs", "defs", "impls" },  -- Track all usage types
                        breakdown = true,                       -- Show "5 refs, 2 defs, 1 impls"
                        show_zero = true,
                    },
                    { name = "last_author", enabled = true }
                },
                style = { render = "all", placement = "inline" }
            },
            {
                name = "informative",
                providers = {
                    { name = "references", enabled = true },
                    { name = "diagnostics", enabled = true, min_level = "HINT" },
                    { name = "complexity", enabled = true }
                },
                style = { render = "focused", placement = "inline" }
            }
        }
    }
}
