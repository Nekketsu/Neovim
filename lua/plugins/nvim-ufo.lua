return {
    'kevinhwang91/nvim-ufo',
    event = "VeryLazy",
    config = function()
        vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
        -- vim.o.foldcolumn = 'auto:9'
        vim.o.foldcolumn = '1'
        vim.o.foldnestmax = 1
        vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

        local handler = function(virtText, lnum, endLnum, width, truncate)
            local newVirtText = {}
            local suffix = (' 󰁂 %d '):format(endLnum - lnum)
            local sufWidth = vim.fn.strdisplaywidth(suffix)
            local targetWidth = width - sufWidth
            local curWidth = 0
            for _, chunk in ipairs(virtText) do
                local chunkText = chunk[1]
                local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                if targetWidth > curWidth + chunkWidth then
                    table.insert(newVirtText, chunk)
                else
                    chunkText = truncate(chunkText, targetWidth - curWidth)
                    local hlGroup = chunk[2]
                    table.insert(newVirtText, {chunkText, hlGroup})
                    chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    -- str width returned from truncate() may less than 2nd argument, need padding
                    if curWidth + chunkWidth < targetWidth then
                        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                    end
                    break
                end
                curWidth = curWidth + chunkWidth
            end
            table.insert(newVirtText, {suffix, 'MoreMsg'})
            return newVirtText
        end

        ---@diagnostic disable-next-line: missing-fields
        require('ufo').setup({
            preview = {
                win_config = {
                    border = {'', '─', '', '', '', '─', '', ''},
                    -- winhighlight = 'Normal:Folded',
                    -- winblend = 1
                },
                mappings = {
                    scrollB = '<C-b>',
                    scrollF = '<C-f>',
                    scrollU = '<C-u>',
                    scrollD = '<C-d>',
                    jumpTop = '[',
                    jumpBot = ']'
                }
            },
            fold_virt_text_handler = handler
        })

        local builtin = require("statuscol.builtin")
        require("statuscol").setup(
            {
                relculright = true,
                segments = {
                    {text = {builtin.foldfunc}, click = "v:lua.ScFa"},
                    {text = {"%s"}, click = "v:lua.ScSa"},
                    {text = {builtin.lnumfunc, " "}, click = "v:lua.ScLa"}
                }
            }
        )
    end,
    keys = {
        -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
        {'zR', function() require('ufo').openAllFolds() end},
        {'zM', function() require('ufo').closeAllFolds() end},
        {'K',
            function()
                local winid = require('ufo').peekFoldedLinesUnderCursor()
                if not winid then
                    if #vim.lsp.get_clients({ bufnr = 0 }) > 0 then
                        vim.lsp.buf.hover()
                    else
                        -- vim.api.nvim_feedkeys("K", "n", false)
                        vim.cmd("normal! K")
                    end
                end
            end,
        }

    },
    dependencies = {
        'kevinhwang91/promise-async',
        'luukvbaal/statuscol.nvim'
    }
}
