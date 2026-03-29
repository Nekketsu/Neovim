vim.cmd.packadd("cfilter")
vim.cmd.packadd("nvim.difftool")
vim.cmd.packadd("nvim.undotree")

vim.keymap.set("n", "<leader>U", require("undotree").open)
