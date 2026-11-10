return {
    'nvim-lualine/lualine.nvim',
    config = function()
        require('lualine').setup {
            options = {
                icons_enabled = true,
                theme = 'tokyonight',
                -- theme = 'vscode',
                -- theme = 'lunar',
                -- theme = 'nord',
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {},
                always_divide_middle = true,
                globalstatus = true
            },
            sections = {
                lualine_a = {
                    { 'mode' },
                },
                lualine_b = {
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
                            { "deleted", format = "-{}", hl = "GitSignsDelete" },
                            { function(status) return (status.is_dirty and status.staged > 0) and "|" or "" end },
                            { function(status) return status.staged > 0 and "" or "" end },
                            { "staged_added", format = "+{}", hl = "GitSignsAdd" },
                            { "staged_modified_and_renamed", format = "~{}", hl = "GitSignsChange" },
                            { function(status) return (status.staged_modified + status.renamed > 0) and
                                "~" + (status.staged_modified + status.renamed) or "" end, hl = "GitSignsChange" },
                            { "staged_deleted", format = "-{}", hl = "GitSignsDelete" },
                            { "staged_renamed", format = "*{}", hl = "GitSignsChange" },
                            -- { "staged_modified", format = "~{}", hl = "SnacksPickerGitStatusModified" },
                            -- { "renamed", format = "*{}", hl = "SnacksPickerGitStatusRenamed" },
                        }
                    },
                    -- 'branch',
                    'diff',
                    'diagnostics'
                },
                lualine_c = {
                    { 'filename',  path = 3 },
                    -- { symbols.get, cond = symbols.has },
                    -- { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available }
                },
                lualine_x = {
                    -- 'aerial',
                    { function() return require("org").statusline() end },
                    {
                        function()
                            return " "
                        end,
                        color = function()
                            local status = require("sidekick.status").get()
                            if status then
                                return status.kind == "Error" and "DiagnosticError" or status.busy and "DiagnosticWarn" or
                                    "Special"
                            end
                        end,
                        cond = function()
                            local status = require("sidekick.status")
                            return status.get() ~= nil
                        end,
                    },
                    {
                        function()
                            local status = require("sidekick.status").cli()
                            return " " .. (#status > 1 and #status or "")
                        end,
                        cond = function()
                            return #require("sidekick.status").cli() > 0
                        end,
                        color = function()
                            return "Special"
                        end
                    },
                    'encoding', 'fileformat', 'filetype',
                },
                lualine_y = {
                    'lsp_status',
                    'progress'
                },
                lualine_z = {
                    'location',
                    { "datetime", style = "%Y-%m-%d | %H:%M:%S" }
                }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {
                "aerial", "fugitive", "lazy", "mason", "nvim-dap-ui", "nvim-tree", "oil", "quickfix", "toggleterm", "trouble"
            }
        }
    end,
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true }
}
