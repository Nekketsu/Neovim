return {
    dir = vim.fn.stdpath("config") .. "/lua/hl.nvim",
    name = "hl",
    lazy = false,
    opts = {
        colors = {
            [1] = "#60a5fa",     -- blue
            [2] = "#34d399",     -- green
            [3] = "#fbbf24",     -- yellow
            [4] = "#f87171",     -- red
        }
    },
    keys = {
        { "<leader>hl1",  function() require("hl").add_visual(1) end,    mode = "v",                             desc = "Highlight selection (blue)" },
        { "<leader>hl2",  function() require("hl").add_visual(2) end,    mode = "v",                             desc = "Highlight selection (green)" },
        { "<leader>hl3",  function() require("hl").add_visual(3) end,    mode = "v",                             desc = "Highlight selection (yellow)" },
        { "<leader>hl4",  function() require("hl").add_visual(4) end,    mode = "v",                             desc = "Highlight selection (red)" },

        { "<leader>hlt1", function() require("hl").toggle_visual(1) end, mode = "v",                             desc = "Toggle highlight (blue)" },
        { "<leader>hlt2", function() require("hl").toggle_visual(2) end, mode = "v",                             desc = "Toggle highlight (green)" },

        { "<leader>hlc1", function() require("hl").add_cursor(1) end,    desc = "Highlight under cursor (blue)" },
        { "<leader>hlc2", function() require("hl").add_cursor(2) end,    desc = "Highlight under cursor (green)" },

        { "<leader>hlC",  function() require("hl").clear_buffer() end,   desc = "Clear buffer highlights" },
        { "<leader>hlX",  function() require("hl").clear_all() end,      desc = "Clear all highlights" },

        { "]h",           function() require("hl.nav").next() end,       desc = "Next highlight" },
        { "[h",           function() require("hl.nav").prev() end,       desc = "Previous highlight" },

        { "<leader>hl1", function() return require("hl").operator_start(1)() end, mode = "n", expr = true },
        { "<leader>hl2", function() return require("hl").operator_start(2)() end, mode = "n", expr = true },
        { "<leader>hl3", function() return require("hl").operator_start(3)() end, mode = "n", expr = true },
    }
}
