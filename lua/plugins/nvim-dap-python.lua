return {
    "mfussenegger/nvim-dap-python",
    config = function ()
        require("dap-python").setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/Scripts/python")
    end
}
