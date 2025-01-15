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
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
