return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        {
            'nvim-treesitter/nvim-treesitter-textobjects',
            opts = {
                select = {
                    lookahead = true
                }
            },
            init = function()
                vim.keymap.set({ "n", "x", "o" }, "]m", function() require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects") end)
                vim.keymap.set({ "n", "x", "o" }, "]m", function() require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects") end)
                vim.keymap.set({ "n", "x", "o" }, "]]", function() require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects") end)
                vim.keymap.set({ "n", "x", "o" }, "]a", function() require("nvim-treesitter-textobjects.move").goto_next_start("@parameter.inner", "textobjects") end)
                -- vim.keymap.set({ "n", "x", "o" }, "]s", function() require("nvim-treesitter-textobjects.move").goto_next_start("@statement.outer", "textobjects") end)
                vim.keymap.set({ "n", "x", "o" }, "]/", function() require("nvim-treesitter-textobjects.move").goto_next_start("@comment.outer", "textobjects") end)


                vim.keymap.set({ "n", "x", "o" }, "]M", function() require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects") end)
                vim.keymap.set({ "n", "x", "o" }, "][", function() require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects") end)
                vim.keymap.set({ "n", "x", "o" }, "]A", function() require("nvim-treesitter-textobjects.move").goto_next_end("@parameter.inner", "textobjects") end)
                -- vim.keymap.set({ "n", "x", "o" }, "]s", function() require("nvim-treesitter-textobjects.move").goto_next_end("@statement.outer", "textobjects") end)
                vim.keymap.set({ "n", "x", "o" }, "]*", function() require("nvim-treesitter-textobjects.move").goto_next_end("@comment.outer", "textobjects") end)


                vim.keymap.set({ "n", "x", "o" }, "[m", function() require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects") end)
                vim.keymap.set({ "n", "x", "o" }, "[[", function() require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects") end)
                vim.keymap.set({ "n", "x", "o" }, "[a", function() require("nvim-treesitter-textobjects.move").goto_previous_start("@parameter.inner", "textobjects") end)
                vim.keymap.set({ "n", "x", "o" }, "[s", function() require("nvim-treesitter-textobjects.move").goto_previous_start("@statement.outer", "textobjects") end)
                vim.keymap.set({ "n", "x", "o" }, "[/", function() require("nvim-treesitter-textobjects.move").goto_previous_start("@comment.outer", "textobjects") end)


                vim.keymap.set({ "n", "x", "o" }, "[M", function() require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects") end)
                vim.keymap.set({ "n", "x", "o" }, "[]", function() require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects") end)
                vim.keymap.set({ "n", "x", "o" }, "[A", function() require("nvim-treesitter-textobjects.move").goto_previous_end("@parameter.inner", "textobjects") end)
                -- vim.keymap.set({ "n", "x", "o" }, "[s", function() require("nvim-treesitter-textobjects.move").goto_previous_end("@statement.outer", "textobjects") end)
                vim.keymap.set({ "n", "x", "o" }, "[*", function() require("nvim-treesitter-textobjects.move").goto_previous_end("@comment.outer", "textobjects") end)

                vim.keymap.set({ "n", "x", "o" }, "]?", function() require("nvim-treesitter-textobjects.move").goto_next("@conditional.outer", "textobjects") end)
                vim.keymap.set({ "n", "x", "o" }, "]@", function() require("nvim-treesitter-textobjects.move").goto_next("@loop.outer", "textobjects") end)

                vim.keymap.set({ "n", "x", "o" }, "[?", function() require("nvim-treesitter-textobjects.move").goto_previous("@conditional.outer", "textobjects") end)
                vim.keymap.set({ "n", "x", "o" }, "[@", function() require("nvim-treesitter-textobjects.move").goto_previous("@loop.outer", "textobjects") end)


                vim.keymap.set({ "x", "o" },"af", function() require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects") end)
                vim.keymap.set({ "x", "o" },"if", function() require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects") end)
                vim.keymap.set({ "x", "o" },"am", function() require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects") end)
                vim.keymap.set({ "x", "o" },"im", function() require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects") end)
                vim.keymap.set({ "x", "o" },"ac", function() require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects") end)
                vim.keymap.set({ "x", "o" },"ic", function() require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects") end)
                -- vim.keymap.set({ "x", "o" },"as", function() require("nvim-treesitter-textobjects.select").select_textobject({ query = "@scope", query_group = "locals", desc = "Select language scope" }, "textobjects") end)
                -- vim.keymap.set({ "x", "o" },"as", function() require("nvim-treesitter-textobjects.select").select_textobject("@statement.outer", "textobjects") end)
                -- vim.keymap.set({ "x", "o" },"is", function() require("nvim-treesitter-textobjects.select").select_textobject("@statement.outer" "textobjects") end)
                vim.keymap.set({ "x", "o" },"aa", function() require("nvim-treesitter-textobjects.select").select_textobject("@parameter.outer", "textobjects") end)
                vim.keymap.set({ "x", "o" },"ia", function() require("nvim-treesitter-textobjects.select").select_textobject("@parameter.inner", "textobjects") end)
                vim.keymap.set({ "x", "o" },"a*", function() require("nvim-treesitter-textobjects.select").select_textobject("@comment.outer", "textobjects") end)
                vim.keymap.set({ "x", "o" },"i*", function() require("nvim-treesitter-textobjects.select").select_textobject("@comment.inner", "textobjects") end)
                vim.keymap.set({ "x", "o" },"a/", function() require("nvim-treesitter-textobjects.select").select_textobject("@comment.outer", "textobjects") end)
                vim.keymap.set({ "x", "o" },"i/", function() require("nvim-treesitter-textobjects.select").select_textobject("@comment.inner", "textobjects") end)
                vim.keymap.set({ "x", "o" },"a?", function() require("nvim-treesitter-textobjects.select").select_textobject("@conditional.outer", "textobjects") end)
                vim.keymap.set({ "x", "o" },"i?", function() require("nvim-treesitter-textobjects.select").select_textobject("@conditional.inner", "textobjects") end)
                vim.keymap.set({ "x", "o" },"i@", function() require("nvim-treesitter-textobjects.select").select_textobject("@loop.inner", "textobjects") end)
                vim.keymap.set({ "x", "o" },"a@", function() require("nvim-treesitter-textobjects.select").select_textobject("@loop.outer", "textobjects") end)
            end,
        },
        -- 'tpope/vim-unimpaired',
        -- 'OXY2DEV/markview.nvim'
        -- 'JoosepAlviste/nvim-ts-context-commentstring',
    },
    lazy = false,
    build = ':TSUpdate',
    config = function()
        local treesitter = require("nvim-treesitter")
        treesitter.install({
            "c", "c_sharp", "cpp", "css", "go", "html", "javascript", "lua",
            "markdown", "markdown_inline", "python", "razor", "regex",
            "rust", "scss", "typescript", "vim", "vimdoc", "query"
        }) 

        -- local installed = treesitter.get_installed()
        -- local group = vim.api.nvim_create_augroup("TreeSitterConfig", { clear = true })
        -- vim.api.nvim_create_autocmd("FileType", {
        --     group = group,
        --     callback = function(args)
        --         if vim.list_contains(installed, vim.treesitter.language.get_lang(args.match)) then
        --             vim.treesitter.start()
        --             vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        --         end
        --     end
        -- })

    end
}
