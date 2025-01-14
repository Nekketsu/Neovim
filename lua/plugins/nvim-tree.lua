return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        sync_root_with_cwd = true
    },
    -- config = true,
    -- config = function()
    --     require("nvim-tree").setup {}
    -- end,
    keys = {
        { "\\", function() vim.cmd("NvimTreeOpen") end }
    }
}
