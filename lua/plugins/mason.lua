-- LSP and completion
return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
        -- ensure_installed = {
        --     "asm_lsp", "clangd", "codelldb", "cpptools", "css-lsp", "csharpier", "debugpy", "emmet-language-server",
        --     "gopls", "html-lsp", "json-lsp", "lua-language-server", "netcoredbg", "pyright",
        --     "roslyn", "rust-analyzer", "rzls", "typescript-language-server", "tinymist", "yaml-language-server"
        -- }
    },
    dependencies = {
        {
            "mason-org/mason.nvim",
            opts = {
                registries = {
                    "github:mason-org/mason-registry",
                    "github:Crashdummyy/mason-registry"
                }
            },
        },
        "neovim/nvim-lspconfig"
    }
}
