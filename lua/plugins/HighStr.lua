return {
    'pocco81/high-str.nvim',
    dependencies = {
        "folke/which-key.nvim",
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        require("high-str.tools.tool-highlight.modules.colors").parse_colors()

        local wk = require("which-key")
        wk.add({
            { "<leader>hl", group = "Highlights" },

            { '<leader>hll', ':<C-u>HSHighlight<CR>', mode = "v", desc = " Pastel yellow", icon = { icon = " ", hl = "DMHGroup1" }},
            { '<leader>hlc', ':<C-u>HSHighlight 0<CR>', mode = "v", desc = " Cosmic charcoal", icon = { icon = " ", hl = "DMHGroup0" }},
            { '<leader>hly', ':<C-u>HSHighlight 1<CR>', mode = "v", desc = " Pastel yellow", icon = { icon = " ", hl = "DMHGroup1" }},
            { '<leader>hla', ':<C-u>HSHighlight 2<CR>', mode = "v", desc = " Aqua menthe", icon = { icon = " ", hl = "DMHGroup2" }},
            { '<leader>hlv', ':<C-u>HSHighlight 3<CR>', mode = "v", desc = " Proton purple", icon = { icon = " ", hl = "DMHGroup3" }},
            { '<leader>hlr', ':<C-u>HSHighlight 4<CR>', mode = "v", desc = " Orange red", icon = { icon = " ", hl = "DMHGroup4" }},
            { '<leader>hlg', ':<C-u>HSHighlight 5<CR>', mode = "v", desc = " Office green", icon = { icon = " ", hl = "DMHGroup5" }},
            { '<leader>hlb', ':<C-u>HSHighlight 6<CR>', mode = "v", desc = " Just blue", icon = { icon = " ", hl = "DMHGroup6" }},
            { '<leader>hlp', ':<C-u>HSHighlight 7<CR>', mode = "v", desc = " Blush pink", icon = { icon = " ", hl = "DMHGroup7" }},
            { '<leader>hlw', ':<C-u>HSHighlight 8<CR>', mode = "v", desc = " Cosmic latte", icon = { icon = " ", hl = "DMHGroup8" }},
            { '<leader>hlf', ':<C-u>HSHighlight 9<CR>', mode = "v", desc = " Fallow brown", icon = { icon = " ", hl = "DMHGroup9" }},

            { '<leader>hld', ':<C-u>HSRmHighlight<CR>', mode = "v", desc = "Remove highlight", icon = "" },
            { '<leader>hlD', ':HSRmHighlight rm_all<CR>', desc = "Remove all highlights", icon = "" },
        })
    end,
}
