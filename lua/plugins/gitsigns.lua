return {
    'lewis6991/gitsigns.nvim',
    config = function()
        require('gitsigns').setup {
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
                local next_hunk_repeat, prev_hunk_repeat = ts_repeat_move.make_repeatable_move_pair(gs.next_hunk, gs.prev_hunk)

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']c', function()
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() next_hunk_repeat() end)
                    return '<Ignore>'
                end, { expr=true, desc = "Next hunk" })

                map('n', '[c', function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() prev_hunk_repeat() end)
                    return '<Ignore>'
                end, { expr=true, desc = "Previous hunk" })

                -- Actions
                map({'n', 'v'}, '<leader>hs', gs.stage_hunk, { desc = "Stage hunk" })
                map({'n', 'v'}, '<leader>hr', gs.reset_hunk, { desc = "Reset hunk" })
                map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Stage hunk" })
                map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Reset hunk" })
                map('n', '<leader>hS', gs.stage_buffer, { desc = "Stage buffer" })
                map('n', '<leader>hu', gs.undo_stage_hunk, { desc = "Undo stage hunk" })
                map('n', '<leader>hR', gs.reset_buffer, { desc = "Reset buffer" })
                map('n', '<leader>hp', gs.preview_hunk, { desc = "Preview hunk" })
                map('n', '<leader>hb', function() gs.blame_line{full=true} end, { desc = "Blame line" })
                map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = "Toggle current line blame" })
                -- map('n', '<leader>hd', gs.diffthis, { desc = "Diff" })
                -- map('n', '<leader>hD', function() gs.diffthis('HEAD') end, { desc = "Diff HEAD" })
                map('n', '<leader>hd', '<cmd>Gvdiffsplit<CR>', { desc = "Diff" })
                map('n', '<leader>hD', '<cmd>Gvdiffsplit HEAD<CR>', { desc = "Diff HEAD" })
                map('n', '<leader>td', gs.toggle_deleted, { desc = "Toggle deleted" })
                map('n', '<leader>hl', gs.toggle_linehl, { desc = "Toggle line highlight" })

                -- Text object
                -- map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = "Select hunk" })
                map({'o', 'x'}, 'ih', gs.select_hunk, { desc = "Select hunk" })
            end
        }
    end
}
