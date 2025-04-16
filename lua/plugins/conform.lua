return {
    'stevearc/conform.nvim',
    opts = {
        -- Define your formatters
        formatters_by_ft = {
            cs = { "csharpier" }
        }
    },
    init = function()
        -- If you want the formatexpr, here is the place to set it
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('ConformLspConfig', {}),
            callback = function(ev)
                vim.b.formatexpr = "v:lua.require'conform'.formatexpr()"
            end
        })
    end,
}
