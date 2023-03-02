return {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    opts = {
        load = {
            ["core.defaults"] = {},
            ["core.concealer"] = {},
            ["core.dirman"] = {
                config = {
                    workspaces = {
                        notes = "~/Notes"
                    },
                    default_workspace = "notes",
                    -- index = "index.norg"
                }
            },
            -- ["core.gtd.base"] = {
            --     config = {
            --         workspace = "home"
            --     }
            -- },
            ["core.manoeuvre"] = {},
            ["core.export"] = {},
            ["core.export.markdown"] = {},
            ["core.qol.toc"] = {},
            ["core.presenter"] = {
                config = {
                    zen_mode = "truezen"
                }
            },
            ["core.completion"] = {
                config = {
                    engine = "nvim-cmp"
                }
            },
            ["core.journal"] = {
                config = {
                    workspace = "notes",
                    journal_folder = "Journal"
                }
            },
            ["core.keybinds"] = {
                config = {
                    hook = function(keybinds)
                        keybinds.map_event("norg", "n", "<Tab>", "core.qol.todo_items.todo.task_cycle")
                        keybinds.map_event("norg", "n", "<S-Tab>", "core.qol.todo_items.todo.task_cycle_reverse")
                        keybinds.map_event("norg", "n", "<C-s>", "core.integrations.telescope.find_linkable")
                        keybinds.map_event("norg", "i", "<C-l>", "core.integrations.telescope.insert_link")
                    end
                }
            },
            ["core.integrations.telescope"] = {}
        }
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-neorg/neorg-telescope"
    }
}
