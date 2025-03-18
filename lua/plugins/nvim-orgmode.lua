---@diagnostic disable: missing-fields
return {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { "org" },
    config = function()
        local org = require("orgmode")
        org.setup({
            ui = {
                input = {
                    use_vim_ui = true
                }
            },
            notifications = {
                enabled = true,
                cron_enabled = false
            },
            org_startup_folded = "inherit",
            org_agenda_files = '~/org/**/*',
            org_default_notes_file = '~/org/refile.org',
            org_agenda_custom_commands = {
                -- "c" is the shortcut that will be used in the prompt
                c = {
                    description = 'Combined view', -- Description shown in the prompt for the shortcut
                    types = {
                        {
                            type = 'tags_todo', -- Type can be agenda | tags | tags_todo
                            match = '+PRIORITY="A"', --Same as providing a "Match:" for tags view <leader>oa + m, See: https://orgmode.org/manual/Matching-tags-and-properties.html
                            org_agenda_overriding_header = 'High priority todos',
                            org_agenda_todo_ignore_deadlines = 'far', -- Ignore all deadlines that are too far in future (over org_deadline_warning_days). Possible values: all | near | far | past | future
                        },
                        {
                            type = 'agenda',
                            org_agenda_overriding_header = 'My daily agenda',
                            org_agenda_span = 'day' -- can be any value as org_agenda_span
                        },
                        {
                            type = 'tags',
                            match = 'WORK', --Same as providing a "Match:" for tags view <leader>oa + m, See: https://orgmode.org/manual/Matching-tags-and-properties.html
                            org_agenda_overriding_header = 'My work todos',
                            org_agenda_todo_ignore_scheduled = 'all', -- Ignore all headlines that are scheduled. Possible values: past | future | all
                        },
                        {
                            type = 'agenda',
                            org_agenda_overriding_header = 'Whole week overview',
                            org_agenda_span = 'week', -- 'week' is default, so it's not necessary here, just an example
                            org_agenda_start_on_weekday = 1, -- Start on Monday
                            org_agenda_remove_tags = true -- Do not show tags only for this view
                        },
                    }
                },
                p = {
                    description = 'Personal agenda',
                    types = {
                        {
                            type = 'tags_todo',
                            org_agenda_overriding_header = 'My personal todos',
                            org_agenda_category_filter_preset = 'todos', -- Show only headlines from `todos` category. Same value providad as when pressing `/` in the Agenda view
                            org_agenda_sorting_strategy = {'todo-state-up', 'priority-down'} -- See all options available on org_agenda_sorting_strategy
                        },
                        {
                            type = 'agenda',
                            org_agenda_overriding_header = 'Personal projects agenda',
                            org_agenda_files = {'~/my-projects/**/*'}, -- Can define files outside of the default org_agenda_files
                        },
                        {
                            type = 'tags',
                            org_agenda_overriding_header = 'Personal projects notes',
                            org_agenda_files = {'~/my-projects/**/*'},
                            org_agenda_tag_filter_preset = 'NOTES-REFACTOR' -- Show only headlines with NOTES tag that does not have a REFACTOR tag. Same value providad as when pressing `/` in the Agenda view
                        },
                    }
                }
            },
            org_capture_templates = {
                T = {
                    description = 'Todo',
                    template = '* TODO %?\n %u',
                    target = '~/org/todo.org'
                },
                j = {
                    description = 'Journal',
                    template = '\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?',
                    target = '~/org/journal.org'
                },
                J = {
                    description = 'Journal',
                    template = '\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?',
                    target = '~/org/journal/%<%Y-%m>.org'
                },
                k = {
                    description = 'Journal',
                    template = '*  Dear journal: %n %?',
                    target = '~/org/kournal.org',
                    datetree = { "day" }
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

            -- mappings = {
            --     org = {
            --         org_toggle_checkbox = "<Leader>."
            --     }
            -- }
        })

        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'org',
            callback = function()
                vim.keymap.set('i', '<S-CR>', '<cmd>lua require("orgmode").action("org_mappings.meta_return")<CR>', {
                    silent = true,
                    buffer = true,
                })
            end,
        })
    end,
    dependencies = {
        {
            "danilshvalov/org-modern.nvim",
            config = function()
                local Menu = require("org-modern.menu")

                require("orgmode").setup({
                    ui = {
                        menu = {
                            handler = function(data)
                                Menu:new():open(data)
                            end,
                        },
                    },
                })
            end
        },
        {
            "nvim-orgmode/org-bullets.nvim",
            config = true
        },
        {
            "nvim-orgmode/telescope-orgmode.nvim",
            event = "VeryLazy",
            dependencies = {
                "nvim-telescope/telescope.nvim",
            },
            config = function()
                require("telescope").load_extension("orgmode")

                vim.keymap.set("n", "<leader>oR", require("telescope").extensions.orgmode.refile_heading, { desc = "Refile heading" })
                vim.keymap.set("n", "<leader>oh", require("telescope").extensions.orgmode.search_headings, { desc = "Search headings" })
                vim.keymap.set("n", "<leader>oL", require("telescope").extensions.orgmode.insert_link, { desc = "Insert link" })
                vim.keymap.set("n", "<leader>of", function() require("telescope.builtin").find_files({ cwd = "~/org" }) end, { desc = "Find ORG files" })
            end,
        },
        {
            "lukas-reineke/headlines.nvim",
            dependencies = "nvim-treesitter/nvim-treesitter",
            config = true, -- or `opts = {}`
        }
    }
}
