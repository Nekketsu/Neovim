---@param  forward boolean
local function go_wrap(forward)
    return function()
        require("demicolon.jump").repeatably_do(function(opts)
            if opts.forward == nil or opts.forward then
                vim.cmd [[ execute "normal! gj"]]
            else
                vim.cmd [[ execute "normal! gk"]]
            end
        end, { forward = forward })
    end
end

local function go_change_list(forward)
    return function()
        require("demicolon.jump").repeatably_do(function(opts)
            if opts.forward == nil or opts.forward then
                vim.cmd [[ execute "normal! g,"]]
            else
                vim.cmd [[ execute "normal! g;"]]
            end
        end, { forward = forward })
    end
end

return {
    'mawkler/demicolon.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    opts = {
        keymaps = {
            repeat_motions = "stateful"
        }
    },
    keys = {
        { "gj", go_wrap(true), desc = "Display lines downward" },
        { "gk", go_wrap(false), desc = "Display lines upward" },
        { "g;", go_change_list(true), desc = "Go to newer position in change list" },
        { "g,", go_change_list(false), desc = "Go to older position in change list" },
    }
}
