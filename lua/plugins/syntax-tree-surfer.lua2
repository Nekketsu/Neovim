return {
    "ziontee113/syntax-tree-surfer",
    config = true,
    --     require('syntax-tree-surfer').setup()
    --
    --     -- Syntax Tree Surfer
    --     local opts = {noremap = true, silent = true}
    --
    --     -- Normal Mode Swapping:
    --     -- Swap The Master Node relative to the cursor with it's siblings, Dot Repeatable
    --     vim.keymap.set("n", "vU", function()
    --         vim.opt.opfunc = "v:lua.STSSwapUpNormal_Dot"
    --         return "g@l"
    --     end, { silent = true, expr = true, desc = "Swap master node" })
    --     vim.keymap.set("n", "vD", function()
    --         vim.opt.opfunc = "v:lua.STSSwapDownNormal_Dot"
    --         return "g@l"
    --     end, { silent = true, expr = true, desc = "Swap master node" })
    --
    --     -- Swap Current Node at the Cursor with it's siblings, Dot Repeatable
    --     vim.keymap.set("n", "vd", function()
    --         vim.opt.opfunc = "v:lua.STSSwapCurrentNodeNextNormal_Dot"
    --         return "g@l"
    --     end, { silent = true, expr = true, desc = "Swap current node" })
    --     vim.keymap.set("n", "vu", function()
    --         vim.opt.opfunc = "v:lua.STSSwapCurrentNodePrevNormal_Dot"
    --         return "g@l"
    --     end, { silent = true, expr = true, desc = "Swap current node" })
    --
    --     --> If the mappings above don't work, use these instead (no dot repeatable)
    --     -- vim.keymap.set("n", "vd", '<cmd>STSSwapCurrentNodeNextNormal<cr>', opts)
    --     -- vim.keymap.set("n", "vu", '<cmd>STSSwapCurrentNodePrevNormal<cr>', opts)
    --     -- vim.keymap.set("n", "vD", '<cmd>STSSwapDownNormal<cr>', opts)
    --     -- vim.keymap.set("n", "vU", '<cmd>STSSwapUpNormal<cr>', opts)
    --
    --     -- Visual Selection from Normal Mode
    --     vim.keymap.set("n", "vx", '<cmd>STSSelectMasterNode<cr>', { noremap = true, silent = true, desc = "Select master node" })
    --     vim.keymap.set("n", "vn", '<cmd>STSSelectCurrentNode<cr>', { noremap = true, silent = true, desc = "Select current node" })
    --
    --     -- Select Nodes in Visual Mode
    --     vim.keymap.set("x", "J", '<cmd>STSSelectNextSiblingNode<cr>', { noremap = true, silent = true, desc = "Select next sibling node" })
    --     vim.keymap.set("x", "K", '<cmd>STSSelectPrevSiblingNode<cr>', { noremap = true, silent = true, desc = "Select prev sibling node" })
    --     vim.keymap.set("x", "H", '<cmd>STSSelectParentNode<cr>', { noremap = true, silent = true, desc = "Select parent node" })
    --     vim.keymap.set("x", "L", '<cmd>STSSelectChildNode<cr>', { noremap = true, silent = true, desc = "Select child node" })
    --
    --     -- Swapping Nodes in Visual Mode
    --     vim.keymap.set("x", "<A-j>", '<cmd>STSSwapNextVisual<cr>', { noremap = true, silent = true, desc = "Swap next node" })
    --     vim.keymap.set("x", "<A-k>", '<cmd>STSSwapPrevVisual<cr>', { noremap = true, silent = true, desc = "Swap prev node" })
    --
    --     -- -- Holds a node, or swaps the held node
    --     -- vim.keymap.set("n", "gnh", "<cmd>STSSwapOrHold<cr>", opts)
    --     -- -- Same for visual
    --     -- vim.keymap.set("x", "gnh", "<cmd>STSSwapOrHoldVisual<cr>", opts)
    -- end,
    keys = {
        -- Swap The Master Node relative to the cursor with it's siblings, Dot Repeatable
        -- {"vU", function()
        --     vim.opt.opfunc = "v:lua.STSSwapUpNormal_Dot"
        --     return "g@l"
        -- end, desc = "Swap master node" },
        -- {"vD", function()
        --     vim.opt.opfunc = "v:lua.STSSwapDownNormal_Dot"
        --     return "g@l"
        -- end, desc = "Swap master node" },
        --
        -- -- Swap Current Node at the Cursor with it's siblings, Dot Repeatable
        -- {"vd", function()
        --     vim.opt.opfunc = "v:lua.STSSwapCurrentNodeNextNormal_Dot"
        --     return "g@l"
        -- end, desc = "Swap current node" },
        -- {"vu", function()
        --     vim.opt.opfunc = "v:lua.STSSwapCurrentNodePrevNormal_Dot"
        --     return "g@l"
        -- end, desc = "Swap current node" },

        --> If the mappings above don't work, use these instead (no dot repeatable)
        {"vd", function() vim.cmd("STSSwapCurrentNodeNextNormal") end},
        {"vu", function() vim.cmd("STSSwapCurrentNodePrevNormal") end},
        {"vD", function() vim.cmd("STSSwapDownNormal") end},
        {"vU", function() vim.cmd("STSSwapUpNormal") end},

        -- Visual Selection from Normal Mode
        {"vx", function() vim.cmd("STSSelectMasterNode") end, desc = "Select master node" },
        {"vn", function() vim.cmd("STSSelectCurrentNode") end, desc = "Select current node" },

        -- Select Nodes in Visual Mode
        {"J", function() vim.cmd("STSSelectNextSiblingNode") end, mode = "x", desc = "Select next sibling node" },
        {"K", function() vim.cmd("STSSelectPrevSiblingNode") end, mode = "x", desc = "Select prev sibling node" },
        {"H", function() vim.cmd("STSSelectParentNode") end, mode = "x", desc = "Select parent node" },
        {"L", function() vim.cmd("STSSelectChildNode") end, mode = "x", desc = "Select child node" },

        -- Swapping Nodes in Visual Mode
        {"<A-j>", function() vim.cmd("STSSwapNextVisual") end, mode = "x", desc = "Swap next node" },
        {"<A-k>", function() vim.cmd("STSSwapPrevVisual") end, mode = "x", desc = "Swap prev node" }

        -- -- Holds a node, or swaps the held node
        -- vim.keymap.set("n", "gnh", "<cmd>STSSwapOrHold<cr>", opts)
        -- -- Same for visual
        -- vim.keymap.set("x", "gnh", "<cmd>STSSwapOrHoldVisual<cr>", opts)
    }
}
