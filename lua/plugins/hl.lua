
local function notify(state, opts)
    Snacks.notify(
        (state and "Enabled" or "Disabled") .. " **" .. opts.name .. "**",
        { title = opts.name, level = state and vim.log.levels.INFO or vim.log.levels.WARN }
    )
end

return {
    dir = vim.fn.stdpath("config") .. "/lua/hl.nvim",
    dependencies = {
        "folke/which-key.nvim",
    },
    opts = {
        persist = true
    },
    name = "hl",
    lazy = false,
    keys = {
        { "<leader>hlC", function() require("hl").clear_buffer() end,  desc = "Clear buffer highlights" },
        { "<leader>hlX", function() require("hl").clear_all() end,     desc = "Clear all highlights" },

        { "]h",          function() require("hl.nav").next() end,      desc = "Next highlight" },
        { "[h",          function() require("hl.nav").prev() end,      desc = "Previous highlight" },

        { "<leader>hlu", function() require("hl").undo_last() end,     mode = "n",                      desc = "Undo last highlight", expr = true },
        { "<leader>hlr", function() require("hl").redo_last() end,     mode = "n",                      desc = "Redo last highlight", expr = true },

        { "<leader>hld", function() return require("hl").remove() end, mode = { "n", "x" },             desc = "Remove highlight",    expr = true, silent = true },

        { "yop", function() local hl = require("hl") hl.toggle() notify(hl.is_enabled(), { name = "Highlights" }) end, desc = "Toggle Highlights" },
        { "[op", function() local hl = require("hl") hl.enable() notify(hl.is_enabled(), { name = "Highlights" }) end, desc = "Enable Highlights" },
        { "]op", function() local hl = require("hl") hl.disable() notify(hl.is_enabled(), { name = "Highlights" }) end, desc = "Disable Highlights" }

    },
    config = function(_, opts)
        local hl = require("hl")
        hl.setup(opts)

        local hl_groups = hl.get_highlights()
        local maps = {
            { "<leader>hl", group = "Highlights" }
        }
        for i, hl in ipairs(hl_groups) do
            table.insert(maps, {
                "<leader>hl" .. i,
                function() return require("hl").add(i) end,
                mode = { "n", "x" },
                desc = "Highlight",
                expr = true,
                icon = { icon = " ", hl = hl },
            })
        end

        local wk = require("which-key")
        wk.add(maps)
    end
}
