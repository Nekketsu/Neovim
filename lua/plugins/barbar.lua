return {
    'romgrk/barbar.nvim',
    dependencies = {
        "lewis6991/gitsigns.nvim",
        "nvim-tree/nvim-web-devicons"
    },
    event = "BufEnter",
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
    },
    keys = {
        -- Move to previous/next
        {'<A-,>', '<Cmd>BufferPrevious<CR>'},
        {'<A-.>', '<Cmd>BufferNext<CR>'},
        -- Re-order to previous/next
        {'<A-<>', '<Cmd>BufferMovePrevious<CR>'},
        {'<A->>', '<Cmd>BufferMoveNext<CR>'},
        -- Goto buffer in position...
        {'<A-1>', '<Cmd>BufferGoto 1<CR>'},
        {'<A-2>', '<Cmd>BufferGoto 2<CR>'},
        {'<A-3>', '<Cmd>BufferGoto 3<CR>'},
        {'<A-4>', '<Cmd>BufferGoto 4<CR>'},
        {'<A-5>', '<Cmd>BufferGoto 5<CR>'},
        {'<A-6>', '<Cmd>BufferGoto 6<CR>'},
        {'<A-7>', '<Cmd>BufferGoto 7<CR>'},
        {'<A-8>', '<Cmd>BufferGoto 8<CR>'},
        {'<A-9>', '<Cmd>BufferGoto 9<CR>'},
        {'<A-0>', '<Cmd>BufferLast<CR>'},
        -- Pin/unpin buffer
        {'<Space><A-p>', '<Cmd>BufferPin<CR>'},
        -- Close buffer
        {'<A-c>', '<Cmd>BufferClose<CR>'},
        {'<A-S-c>', '<Cmd>BufferCloseAllButCurrent<CR>'},
        -- Wipeout buffer
        --                 :BufferWipeout
        -- Close commands
        --                 :BufferCloseAllButCurrent
        --                 :BufferCloseAllButPinned
        --                 :BufferCloseAllButCurrentOrPinned
        --                 :BufferCloseBuffersLeft
        --                 :BufferCloseBuffersRight
        -- Magic buffer-picking mode
        {'<Space><C-p>', '<Cmd>BufferPick<CR>' },
        -- Sort automatically by...
        {'<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>' },
        {'<Space>bd', '<Cmd>BufferOrderByDirectory<CR>' },
        {'<Space>bl', '<Cmd>BufferOrderByLanguage<CR>' },
        {'<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>' },

        -- Other:
        -- :BarbarEnable - enables barbar (enabled by default)
        -- :BarbarDisable - very bad command, should never be used
    }
}
