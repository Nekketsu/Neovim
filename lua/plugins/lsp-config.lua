return {
    "neovim/nvim-lspconfig",
    config = function()

        -- Global mappings.
        -- See `:help vim.diagnostic.*` for documentation on any of the below functions
        -- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

        -- Use LspAttach autocommand to only map the following keys
        -- after the language server attaches to the current buffer
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                -- Enable completion triggered by <c-x><c-o>
                vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local opts = { buffer = ev.buf }

                vim.keymap.set("n", "<leader>D", vim.diagnostic.open_float, opts)
                vim.keymap.set('n', '<space>K', vim.lsp.buf.signature_help, opts)
                vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
                vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
                vim.keymap.set('n', '<space>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, opts)

                local client = vim.lsp.get_client_by_id(ev.data.client_id)

                if client == nil then return end

                if client.server_capabilities.inlayHintProvider then
                    vim.lsp.inlay_hint.enable( true);
                    vim.keymap.set("n", "[oy", function() vim.lsp.inlay_hint.enable(true); end, opts)
                    vim.keymap.set("n", "]oy", function() vim.lsp.inlay_hint.enable(false); end, opts)
                    vim.keymap.set("n", "yoy", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()); end, opts)
                end
            end,
        })
    end
}
