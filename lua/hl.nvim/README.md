# hl.nvim

Simple text highlighter for Neovim presentations. Apply color highlights to visual selections or motions using extmarks.

## Installation

With lazy.nvim (local plugin):

```lua
{ dir = vim.fn.stdpath("config") .. "/lua/hl.nvim", lazy = false }
```

## Setup

```lua
require('hl').setup {
  highlights = {
    { bg = "#f59e0b", fg = "#18181b" }, -- table spec  → HlColor1
    "#3b82f6",                           -- hex string  → HlColor2
    "Search",                            -- group name  → HlColor3 (copies attrs)
  },
  persist = { enabled = true, path = vim.fn.stdpath('data') .. '/hl.json' },
}
```

`highlights` is an ordered list; position = color index (1, 2, 3 ...).  
Defaults to 4 colors: amber, blue, green, red.

## Commands

| Command | Description |
|---------|-------------|
| `:HlAdd [index\|group\|#hex]` | Add highlight from visual selection or start operator (normal mode) |
| `:HlRemove [filter]` | Remove highlights overlapping visual selection or at cursor |
| `:HlRemoveCursor` | Remove highlight under cursor |
| `:HlUndo` | Undo last highlight (current buffer) |
| `:HlRedo` | Redo last undone |
| `:HlSave [path]` | Save state to disk |
| `:HlLoad [path]` | Load state from disk |
| `:HlClear` | Clear highlights in current buffer |
| `:HlClearAll` | Clear all highlights globally |
| `:HlEnable` | Enable highlights globally |
| `:HlDisable` | Disable highlights globally |
| `:HlToggle` | Toggle global enabled state |
| `:HlList` | List highlights in current buffer |

## Lua API

```lua
local hl = require('hl')

hl.setup(opts)
hl.add(color)          -- integer index, group name, or nil (→ 1)
hl.remove(filter)      -- optional color filter
hl.recolor(new_color)  -- change color of highlight under cursor
hl.remove_at_cursor()
hl.undo_last()
hl.redo_last()
hl.clear_buffer()
hl.clear_all()
hl.enable()
hl.disable()
hl.toggle()
hl.is_enabled()        -- → boolean
hl.get_highlights()    -- → string[]  e.g. {"HlColor1","HlColor2",...}
hl.count()             -- → integer   highlights in current buffer
hl.statusline()        -- → string    e.g. " hl:3" or " hl:off"
hl.get_state()         -- → table<string, HlHighlight[]>  (read-only view)
```

## Keymaps

```lua
-- Visual mode: apply color 1, 2, ... with <cmd> to preserve v:count
vim.keymap.set({ "n", "x" }, "<leader>ha", "<cmd>lua require('hl').add(1)<cr>")
vim.keymap.set({ "n", "x" }, "<leader>hb", "<cmd>lua require('hl').add(2)<cr>")

-- Normal mode: operator (apply with motion)
vim.keymap.set("n", "<leader>ha", function() return require('hl').add(1) end, { expr = true })

-- Navigation
vim.keymap.set("n", "]h", function() require('hl.nav').next() end)
vim.keymap.set("n", "[h", function() require('hl.nav').prev() end)

-- Undo / redo
vim.keymap.set("n", "<leader>hu", "<cmd>HlUndo<cr>")
vim.keymap.set("n", "<leader>hU", "<cmd>HlRedo<cr>")

-- Toggle (unimpaired-style)
vim.keymap.set("n", "yop", "<cmd>HlToggle<cr>")
```

## Statusline / Lualine

```lua
-- lualine component
{ require('hl').statusline }
-- returns: " hl:3"  (when enabled with 3 highlights)
--          " hl:off" (when disabled)
--          ""        (when enabled but no highlights)
```

## Navigation

```lua
require('hl.nav').next()  -- jump to next highlight in buffer
require('hl.nav').prev()  -- jump to previous highlight
```

## License

MIT
