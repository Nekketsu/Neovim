return {
    "jameswolensky/marker-groups.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim", -- Required
        "folke/snacks.nvim",
    },
    config = function()
        require("marker-groups").setup({
            -- Your configuration here
            picker = 'snacks'
        })
    end,
}
