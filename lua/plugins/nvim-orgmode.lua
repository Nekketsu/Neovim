return {
    'nvim-orgmode/orgmode',
    config = function()
        -- -- Load custom tree-sitter grammar for org filetype
        -- require('orgmode').setup_ts_grammar()
        --
        -- -- Tree-sitter configuration
        -- require'nvim-treesitter.configs'.setup {
        --     -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
        --     highlight = {
        --         enable = true,
        --         additional_vim_regex_highlighting = { 'org' }, -- Required since TS highlighter doesn't support all syntax features (conceal)
        --     },
        --     ensure_installed = {'org'}, -- Or run :TSUpdate org
        -- }

        require('orgmode').setup({
            org_agenda_files = '~/org/**/*',
            org_default_notes_file = '~/org/refile.org',
            org_capture_templates = {
                T = {
                    description = 'Todo',
                    template = '* TODO %?\n %u',
                    target = '~/org/todo.org'
                },
                j = {
                    description = 'Journal',
                    template = '\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?',
                    -- target = '~/org/journal.org'
                },
                J = {
                    description = 'Journal',
                    template = '\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?',
                    target = '~/org/journal/%<%Y-%m>.org'
                },
                e = {
                    description = 'Event',
                    subtemplates = {
                        r = {
                            description = 'recurring',
                            template = '** %?\n %T',
                            target = '~/org/calendar.org',
                            headline = 'recurring'
                        },
                        o = {
                            description = 'one-time',
                            template = '** %?\n %T',
                            target = '~/org/calendar.org',
                            headline = 'one-time'
                        },
                    },
                },
                o = {
                    description = 'Journal',
                    template = '* %(return vim.fn.getreg "w")',
                    -- get the content of register "w"
                    target = '~/org/journal.org'
                },
                r = {
                    description = "Repo",
                    template = "* [[%x][%(return string.match('%x', '([^/]+)$'))]]%?",
                    target = "~/org/repos.org",
                }
            },
            mappings = {
                org = {
                    org_toggle_checkbox = "<Leader>."
                }
            }
        })

        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'org',
            group = vim.api.nvim_create_augroup('orgmode_telescope_nvim', { clear = true }),
            callback = function()
                vim.keymap.set('n', '<leader>or', '<cmd>Telescope orgmode refile_heading<CR>')
            end,
        })
    end,
    dependencies = {
        'joaomsa/telescope-orgmode.nvim',
        -- { 'nvim-treesitter/nvim-treesitter', lazy = true },
    },
    event = 'VeryLazy'
}
