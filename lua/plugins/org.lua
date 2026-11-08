-- ~/.config/nvim/lua/plugins/org.lua
return {
    "xheisenbugx/org.nvim",
    main = "org",
    lazy = false, -- startup cost is small: heavy modules load on first use
    config = function()
        require("org").setup({
            org_directory = "~/org/orgfiles",
            agenda_files = { "~/org/**/*.org" },
            default_notes_file = "~/org/orgfiles/inbox.org",
            goto_interface = "outline-path-completion",
            capture = {
                templates = {
                    t = { description = "Task", template = "* TODO %?\n  %U\n  %a", target = "inbox.org" },
                    w = "Work...", -- a group: w → wt, wm
                    wt = { description = "Work task", template = "* TODO %? :work:", target = "work.org", headline = "Inbox" },
                    wm = { description = "Meeting", template = "* %^{Who} %^g\n  %T\n  %?", target = "/work.org", olp = { "Meetings" }, clock_in = true },
                    j = { description = "Journal", template = "* %<%H:%M> %?", target = "journal.org", datetree = true },
                    c = { description = "Checklist item", type = "checkitem", template = "[ ] %?", target = "todo.org", headline = "Shopping" },
                    l = { description = "Log line", type = "table-line", template = "| %U | %^{Amount} | %^{What} |", target = "log.org", headline = "Expenses", immediate_finish = true },
                    q = { description = "Quote", target = "reading.org", headline = "Snippets", template = "* %^{Title}\n  #+begin_quote\n  %i\n  #+end_quote\n  From %a"}
                },
                window = "split", -- "split" (like Emacs) | "float" | "vsplit" | "tab" | "current"
            },
            refile = {
                targets = {{files = "agenda", maxlevel = 2}},
                use_outline_path = "file",
                allow_creating_parent_nodes = "confirm"
            },
            agenda = {
                custom_commands = {
                    w = {
                        description = "Work overview",
                        types = {
                            { type = "agenda",    span = "day",              header = "Today" },
                            { type = "tags_todo", match = "+work-someday/!", header = "Open work tasks" },
                            { type = "todo",      match = "WAITING",         header = "Waiting for" },
                        },
                    },
                    u = { description = "Urgent", type = "tags", match = 'PRIORITY="A"|+urgent' },
                    q = { type = "org-ql", query = "(and (todo) (scheduled :to today))", sort = "date", description = "Due" },
                    o = { description = "Open tasks by owner", type = "todo", super_groups = { { auto_property = "OWNER" } } },
                    d = {
                        description = "Daily review",
                        types = {
                            { type = "agenda", span = "day", header = "Today" },
                            { type = "tags_todo", match = 'PRIORITY="A"', header = "Top priority" },
                            { type = "todo", match = "WAITING", header = "Waiting on others" },
                            { type = "stuck", header = "Stuck projects" }
                        }
                    },
                    D = { description = "Due soon, by owner", type = "org-ql", query = "(and (todo) (or (deadline :to 7) (scheduled :to today)))", sort = "date", super_groups = { { auto_property = "OWNER" } } }
                },
            },
            extensions = {
                lsp = true,
                -- src_lsp = { languages = { "lua", "python" } },
                ql = {
                    views = {
                        ["Work"] = { query = "todo: tags:work", sort = { "priority", "date" } },
                        ["Due this week"] = { query = "todo: deadline:to=7", sort = "deadline", super_groups = false }
                    }
                },
                quickadd = true,
                review = true,
                roam = { directory = "~/org/roam" },
                transclusion = true,
                journal = { directory = "~/org/journal" },
                super_agenda = {
                    -- groups = {
                    --     { name = "Today",               time_grid = true,           date = "today" },
                    --     { name = "Important",           priority = "A" },
                    --     { name = "Due soon",            deadline = "future",        order = 2 },
                    --     { name = "Work",                tag = { "work", "office" }, order = 1 },
                    --     { discard = { tag = "someday" } },
                    --     { auto_category = true,         order = 9 },
                    -- },
                    groups = {
                        { name = "Schedule",          time_grid = true },
                        { name = "Waiting on others", todo = "WAITING", order = 3 },
                        {
                            name = "Overdue",
                            deadline = "past",
                            scheduled = "past",
                            order = 1,
                            face = { bg = "#45243a", append = true }
                        },
                        { name = "Important",           priority = "A", order = 2 },
                        { name = "Habits",              habit = true,   order = 4 },
                        { discard = { tag = "someday" } },
                        { auto_category = true,         order = 9 }
                    }
                },
                code = true,
                present = true,
                drill = { scope = "agenda" },
                pomodoro = { work = 25 },
                kanban = true,
                timeline = true,
                heatmap = true,
                sidebar = true
            },
            mappings = {
                global = {
                    pick_headline_all = "<leader>foH",
                    pick_tag = "<leader>fog",
                    pick_agenda = "<leader>foa",
                    pick_agenda_week = "<leader>fow",
                    pick_todo = "<leader>fot",
                    pick_agenda_file = "<leader>fof",
                    pick_capture_template = "<leader>foc"
                },
                org = {
                    pick_headline = "<leader>foh",
                    pick_set_tags = "<leader>foG",
                }
            }
        })
    end,
    keys = {
        { "<leader>foo", function() Snacks.picker.files({ cwd = "~/org/orgfiles" }) end, desc = "Find ORG files" },
        { "<leader>soo", function() Snacks.picker.grep({ cwd = "~/org/orgfiles" }) end,  desc = "Search ORG files" },
        { "<leader>fom", function() Snacks.picker.files({ cwd = "~/org/roam" }) end,     desc = "Find ROAM files" },
        { "<leader>som", function() Snacks.picker.grep({ cwd = "~/org/roam" }) end,      desc = "Search ROAM files" },
        { "<leader>foL", function() Snacks.picker.files({ cwd = "~/org/journal" }) end,  desc = "Find Journal files" },
        { "<leader>soL", function() Snacks.picker.grep({ cwd = "~/org/journal/" }) end,  desc = "Search Journal files" }
    }
}
