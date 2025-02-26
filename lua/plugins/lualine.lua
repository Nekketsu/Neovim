return {
    'nvim-lualine/lualine.nvim',
    config = function()
        local trouble = require("trouble")
        local symbols = trouble.statusline({
            mode = "lsp_document_symbols",
            groups = {},
            title = false,
            filter = { range = true },
            format = "{kind_icon}{symbol.name:Normal}",
            -- The following line is needed to fix the background color
            -- Set it to the lualine section you want to use
            hl_group = "lualine_c_normal",
        })


        require('lualine').setup {
            options = {
                icons_enabled = true,
                theme = 'tokyonight',
                -- theme = 'vscode',
                -- theme = 'lunar',
                component_separators = { left = '', right = ''},
                section_separators = { left = '', right = ''},
                disabled_filetypes = {},
                always_divide_middle = true,
                globalstatus = true
            },
            sections = {
                lualine_a = {
                    { 'mode' }
                },
                lualine_b = {
                    -- {'FugitiveHead', icon = ''},
                    -- {'b:gitsigns_head', icon = ''},
                    {
                        "gitstatus",
                        sections = {
                            -- { "branch", format = " {}" },
                            { "branch", format = " {}" },
                            -- { "is_dirty", format = "*" },
                            { "up_to_date", format = "≡" },
                            { "ahead", format = "↑{}", hl = "SnacksPickerGitStatus" },
                            { "behind", format = "↓{}", hl = "SnacksPickerGitStatus" },
                            { "is_dirty", format = "" },
                            { "conflicted", format = "!{}", hl = "GitSignsAdd" },
                            { "untracked", format = "?{}", hl = "GitSignsAdd" },
                            { "modified", format = "~{}", hl = "GitSignsChange" },
                            { "deleted", format = "-{}" , hl = "GitSignsDelete" },
                            -- { "conflicted", format = "!{}", hl = "SnacksPickerGitStatusUnmerged" },
                            -- { "untracked", format = "?{}", hl = "SnacksPickerGitStatusUntracked" },
                            -- { "modified", format = "~{}", hl = "SnacksPickerGitStatusModified" },
                            -- { "deleted", format = "-{}" , hl = "SnacksPickerGitStatusDeleted" },
                            { "is_dirty_and_has_staged", format = "|" },
                            { "has_staged", format = "" },
                            { "staged_added", format = "+{}", hl = "GitSignsAdd" },
                            { "staged_modified_and_renamed", format = "~{}", hl = "GitSignsChange" },
                            { "staged_deleted", format = "-{}", hl = "GitSignsDelete" },
                            { "staged_renamed", format = "*{}", hl = "GitSignsChange" },
                            -- { "staged_added", format = "+{}", hl = "SnacksPickerGitStatusAdded" },
                            -- -- { "staged_modified", format = "~{}", hl = "SnacksPickerGitStatusModified" },
                            -- { "staged_modified_and_renamed", format = "~{}", hl = "SnacksPickerGitStatusModified" },
                            -- { "staged_deleted", format = "-{}", hl = "SnacksPickerGitStatusDeleted" },
                            -- { "staged_renamed", format = "*{}", hl = "SnacksPickerGitStatusRenamed" },
                            -- { "renamed", format = "*{}", hl = "SnacksPickerGitStatusRenamed" },
                        }
                    },
                    -- 'branch',
                    'diff',
                    'diagnostics'
                },
                lualine_c = {
                    { 'filename', path = 3 },
                    { symbols.get, cond = symbols.has }
                    -- { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available }
                },
                lualine_x = {
                    -- 'aerial',
                    {
                        require("noice").api.status.message.get_hl,
                        cond = require("noice").api.status.message.has,
                    },
                    {
                        require("noice").api.status.command.get,
                        cond = require("noice").api.status.command.has,
                        color = { fg = "#ff9e64" },
                    },
                    {
                        require("noice").api.status.mode.get,
                        cond = require("noice").api.status.mode.has,
                        color = { fg = "#ff9e64" },
                    },
                    {
                        require("noice").api.status.search.get,
                        cond = require("noice").api.status.search.has,
                        color = { fg = "#ff9e64" },
                    },
                    "overseer",
                    'encoding', 'fileformat', 'filetype'
                },
                lualine_y = {'progress'},
                lualine_z = {'location'}
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {'filename'},
                lualine_x = {'location'},
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
        }
    end,
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true }
}
