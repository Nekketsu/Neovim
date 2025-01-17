return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        sync_root_with_cwd = true,
        update_focused_file = {
            update_root = {
                enable = true
            }
        },
        on_attach = function(bufnr)
            local api = require('nvim-tree.api')

            local function opts(desc)
                return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            -- Default mappings
            api.config.mappings.default_on_attach(bufnr)

            -- Custom mappings
            vim.keymap.set('n', 'A', function()
                local node = api.tree.get_node_under_cursor()
                local path = node.type == "directory" and node.absolute_path or vim.fs.dirname(node.absolute_path)
                require("easy-dotnet").create_new_item(path)
            end, opts('Create file from dotnet template'))
        end
    },
    -- config = true,
    -- config = function()
    --     require("nvim-tree").setup {}
    -- end,
    keys = {
        { "\\", function() vim.cmd("NvimTreeFindFile") end },
    }
}
