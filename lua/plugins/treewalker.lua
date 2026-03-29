return {
    "aaronik/treewalker.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",

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
        -- highlight_group = "ColorColumn",
        highlight_group = "CursorLine",

        -- select = true
    },
    init = function()
        local treesitter = require("nvim-treesitter")
        local installed = treesitter.get_installed()
        local group = vim.api.nvim_create_augroup("TreeWalkerConfig", { clear = true })
        vim.api.nvim_create_autocmd("FileType", {
            group = group,
            callback = function(args)
                if vim.list_contains(installed, vim.treesitter.language.get_lang(args.match)) then
                    vim.keymap.set({"n", "v"}, "<C-k>", "<cmd>Treewalker Up<cr>", { buffer = args.buf })
                    vim.keymap.set({"n", "v"}, "<C-j>", "<cmd>Treewalker Down<cr>", { buffer = args.buf })
                    vim.keymap.set({"n", "v"}, "<C-l>", "<cmd>Treewalker Right<cr>", { buffer = args.buf })
                    vim.keymap.set({"n", "v"}, "<C-h>", "<cmd>Treewalker Left<cr>", { buffer = args.buf })
                    vim.keymap.set("n", "<A-j>", "<cmd>Treewalker SwapDown<cr>", { buffer = args.buf })
                    vim.keymap.set("n", "<A-k>", "<cmd>Treewalker SwapUp<cr>", { buffer = args.buf })
                    vim.keymap.set("n", "<A-l>", "<cmd>TSTextobjectSwapNext @parameter.inner<CR>", { buffer = args.buf })
                    vim.keymap.set("n", "<A-h>", "<cmd>TSTextobjectSwapPrevious @parameter.inner<CR>", { buffer = args.buf })
                end
            end
        })
    end,
    -- keys = {
    --     { "<C-k>", "<cmd>Treewalker Up<cr>",                        mode = { "n", "v" } },
    --     { "<C-j>", "<cmd>Treewalker Down<cr>",                      mode = { "n", "v" } },
    --     { "<C-l>", "<cmd>Treewalker Right<cr>",                     mode = { "n", "v" } },
    --     { "<C-h>", "<cmd>Treewalker Left<cr>",                      mode = { "n", "v" } },
    --     { "<A-j>", '<cmd>Treewalker SwapDown<cr>' },
    --     { "<A-k>", '<cmd>Treewalker SwapUp<cr>' },
    --     { "<A-l>", "<cmd>TSTextobjectSwapNext @parameter.inner<CR>" },
    --     { "<A-h>", "<cmd>TSTextobjectSwapPrevious @parameter.inner<CR>" },
    -- }
}
