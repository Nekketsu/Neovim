return {
    'lewis6991/gitsigns.nvim',
    config = function()
        require('gitsigns').setup {
            on_attach = function(bufnr)
                local gigsigns = package.loaded.gitsigns

                -- local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
                -- local next_hunk_repeat, prev_hunk_repeat = ts_repeat_move.make_repeatable_move_pair(gs.next_hunk, gs.prev_hunk)

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- -- Navigation
                -- map('n', ']c', function()
                --     if vim.wo.diff then return ']c' end
                --     vim.schedule(function() next_hunk_repeat() end)
                --
                --     return '<Ignore>'
                -- end, { expr=true, desc = "Next hunk" })
                --
                -- map('n', '[c', function()
                --     if vim.wo.diff then return '[c' end
                --     vim.schedule(function() prev_hunk_repeat() end)
                --     return '<Ignore>'
                -- end, { expr=true, desc = "Previous hunk" })

                -- Navigation
                map('n', ']c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({']c', bang = true})
                    else
                        gigsigns.nav_hunk('next')
                    end
                end)

                map('n', '[c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({'[c', bang = true})
                    else
                        gigsigns.nav_hunk('prev')
                    end
                end)

                -- Actions
                map('n', '<leader>hs', gigsigns.stage_hunk, { desc = "Stage hunk" })
                map('n', '<leader>hr', gigsigns.reset_hunk, { desc = "Reset hunk" })
                map('v', '<leader>hs', function() gigsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Stage hunk" })
                map('v', '<leader>hr', function() gigsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Reset hunk" })
                map('n', '<leader>hS', gigsigns.stage_buffer, { desc = "Stage buffer" })
                map('n', '<leader>hR', gigsigns.reset_buffer, { desc = "Reset buffer" })
                map('n', '<leader>hp', gigsigns.preview_hunk, { desc = "Preview hunk" })
                map('n', '<leader>hi', gigsigns.preview_hunk_inline, { desc = "Preview hunk inline" })
                map('n', '<leader>hu', gigsigns.undo_stage_hunk, { desc = "Undo stage hunk" })

                map('n', '<leader>hb', function() gigsigns.blame_line { full = true } end, { desc = "Blame line" })

                map('n', '<leader>hd', gigsigns.diffthis, { desc = "Diff" })
                map('n', '<leader>hD', function() gigsigns.diffthis('~') end, { desc = "Diff HEAD" })

                map('n', '<leader>hQ', function() gigsigns.setqflist('all') end, { desc = "Send all to quickfix" })
                map('n', '<leader>hq', gigsigns.setqflist, { desc = "Send to quickfix" })

                map('n', '<leader>td', gigsigns.toggle_deleted, { desc = "Toggle deleted" })
                map('n', '<leader>hl', gigsigns.toggle_linehl, { desc = "Toggle line highlight" })

                -- Toggles
                map('n', '<leader>tb', gigsigns.toggle_current_line_blame, { desc = "Toggle current line blame" })
                map('n', '<leader>tw', gigsigns.toggle_word_diff, { desc = "Toggle word diff" })
                -- Text object
                -- map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = "Select hunk" })
                map({'o', 'x'}, 'ih', gigsigns.select_hunk, { desc = "Select hunk" })
            end
        }
    end
}
