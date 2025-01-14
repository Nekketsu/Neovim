return {
    "aaronik/treewalker.nvim",

    -- The following options are the defaults.
    -- Treewalker aims for sane defaults, so these are each individually optional,
    -- and the whole opts block is optional as well.
    opts = {
        -- Whether to briefly highlight the node after jumping to it
        highlight = true,

        -- How long should above highlight last (in ms)
        highlight_duration = 250,

        -- The color of the above highlight. Must be a valid vim highlight group.
        -- (see :h highlight-group for options)
        highlight_group = "ColorColumn",
    },
    keys = {
        { "<C-k>", "<cmd>Treewalker Up<cr>",                        mode = { "n", "v" } },
        { "<C-j>", "<cmd>Treewalker Down<cr>",                      mode = { "n", "v" } },
        { "<C-l>", "<cmd>Treewalker Right<cr>",                     mode = { "n", "v" } },
        { "<C-h>", "<cmd>Treewalker Left<cr>",                      mode = { "n", "v" } },
        { "<A-j>", '<cmd>Treewalker SwapDown<cr>' },
        { "<A-k>", '<cmd>Treewalker SwapUp<cr>' },
        { "<A-l>", "<cmd>TSTextobjectSwapNext @parameter.inner<CR>" },
        { "<A-h>", "<cmd>TSTextobjectSwapPrevious @parameter.inner<CR>" },
    }
}
