-- Map leader to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Sensible defaults
require('settings')

-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if not vim.loop.fs_stat(lazypath) then
--     local lazyrepo = "https://github.com/folke/lazy.nvim.git"
--     vim.fn.system({
--         "git",
--         "clone",
--         "--filter=blob:none",
--         "--branch=stable", -- latest stable release
--         lazyrepo,
--         lazypath
--     })
-- end
-- vim.opt.rtp:prepend(lazypath)
--
-- -- Install plugins
-- require("lazy").setup("plugins")

require("config.lazy")
-- Key mappings
require('keymappings')
require('config')

vim.api.nvim_create_autocmd("WinLeave", {
    callback = function()
        if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
        end
    end,
})
