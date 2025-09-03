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
                -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
                vim.keymap.set('n', '<space>K', vim.lsp.buf.signature_help, opts)
                vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
                vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
                vim.keymap.set('n', '<space>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, opts)
                -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
                -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
                -- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
                -- vim.keymap.set('n', 'grr', vim.lsp.buf.references, bufopts)
                -- vim.keymap.set('n', '<space>F', function() vim.lsp.buf.format { async = true } end, opts)

                -- vim.keymap.set('n', '<space>ll', vim.lsp.codelens.refresh, opts)
                -- vim.keymap.set('n', '<space>lr', vim.lsp.codelens.run, opts)

                -- vim.lsp.codelens.refresh()

                local client = vim.lsp.get_client_by_id(ev.data.client_id)

                -- if client == nil then
                --     return
                -- end
                --
                -- if client.supports_method("textDocument/codeLens", { bufnr = ev.buf }) then
                --     vim.cmd [[
                --     augroup lsp_document_codelens
                --     autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh({ bufnr = ev.buf })
                --     augroup END
                --     ]]
                -- end

                -- if client.supports_method("textDocument/codeLens", { bufnr = ev.buf }) then
                --     vim.api.nvim_create_autocmd("lsp_codelens_refresh", {
                --         buffer = ev.buf,
                --         events = { "BufEnter", "CursorHold", "InsertLeave" },
                --         desc = "Refresh codelens",
                --         callback = function()
                --             if client.server_capabilities.codeLensProvider then
                --                 vim.lsp.codelens.refresh({ bufnr = ev.buf })
                --             end
                --         end,
                --     })
                -- end

                if client.server_capabilities.inlayHintProvider then
                    vim.lsp.inlay_hint.enable( true);
                    vim.keymap.set("n", "[oy", function() vim.lsp.inlay_hint.enable(true); end, opts)
                    vim.keymap.set("n", "]oy", function() vim.lsp.inlay_hint.enable(false); end, opts)
                    vim.keymap.set("n", "yoy", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()); end, opts)
                end
            end,
        })

        -- local lspconfig = require("lspconfig")
        --
        -- -- local capabilities = require("blink.cmp").get_lsp_capabilities()
        -- local handlers = {
        --     -- The first entry (without a key) will be the default handler
        --     -- and will be called for each installed server that doesn't have
        --     -- a dedicated handler.
        --     function(server_name) -- default handler (optional)
        --         lspconfig[server_name].setup {
        --             -- capabilites = capabilities
        --             -- on_attach = on_attach,
        --             -- capabilities = capabilities
        --         }
        --     end,
        --     -- Next, you can provide targeted overrides for specific servers.
        --     -- ["lua_ls"] = function()
        --     --     lspconfig.lua_ls.setup {
        --     --         settings = {
        --     --             Lua = {
        --     --                 diagnostics = {
        --     --                     globals = { "vim" }
        --     --                 },
        --     --                 workspace = {
        --     --                     checkThirdParty = false
        --     --                 },
        --     --                 hint = { enable = true }
        --     --             }
        --     --         },
        --     --     }
        --     -- end,
        --     -- ["omnisharp"] = function()
        --     --     lspconfig.omnisharp.setup({
        --     --         enable_roslyn_analyzers = true,
        --     --         handlers = {
        --     --             ["textDocument/definition"] = require("omnisharp_extended").handler
        --     --         }
        --     --     })
        --     -- end,
        --     ["rust_analyzer"] = function()
        --     end
        -- }
        --
        -- require("mason").setup({
        --     registries = {
        --         "github:mason-org/mason-registry",
        --         "github:Crashdummyy/mason-registry"
        --     }
        -- })
        -- require("mason-lspconfig").setup {
        --     handlers = handlers
        -- }
    end
}
