-- Lua:
-- For dark theme (neovim's default)
vim.o.background = 'dark'
-- For light theme
-- vim.o.background = 'light'

local c = require('vscode.colors').get_colors()
require('vscode').setup({
    -- Enable transparent background
    -- transparent = true,

    -- Enable italic comment
    -- italic_comments = true,

    -- Disable nvim-tree background color
    -- disable_nvimtree_bg = true,

    -- Override colors (see ./lua/vscode/colors.lua)
    -- color_overrides = {
    -- vscLineNumber = '#FFFFFF',
    -- },

    -- Override highlight groups (see ./lua/vscode/theme.lua)
    group_overrides = {
        -- this supports the same val table as vim.api.nvim_set_hl
        -- use colors from this colorscheme by requiring vscode.colors!
        -- Cursor = { fg=c.vscDarkBlue, bg=c.vscLightGreen, bold=true },

        ["@keyword"] = { fg = c.vscBlue, bg = c.vscNone },
        ["@include"] = { fg = c.vscBlue, bg = c.vscNone },
        ["@keyword.return"] = { fg = c.vscPink, bg = c.vscNone },

        ["TelescopeBorder"] = { fg = c.vscBlueGreen, bg = c.vscNone },
        ["TelescopePreviewBorder"] = { fg = c.vscBlueGreen, bg = c.vscNone },
        ["TelescopePromptBorder"] = { fg = c.vscBlueGreen, bg = c.vscNone },
        ["TelescopeResultsBorder"] = { fg = c.vscBlueGreen, bg = c.vscNone },
    }
})

-- vim.o.background = 'dark'
