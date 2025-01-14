local keymaps = vim.api.nvim_buf_get_keymap(0, "n")

for index, value in ipairs(keymaps) do
    if value.lhs == "a" then
        print(vim.inspect(value.callback))
    end
end
