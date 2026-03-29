-- Map leader to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Sensible defaults
require('settings')

require("config.lazy")
require("config.plugins")

-- Key mappings
require('keymappings')
