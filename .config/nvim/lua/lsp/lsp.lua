local lspconfig = require("lspconfig")

lspconfig.bashls.setup({})
lspconfig.cssls.setup({})
lspconfig.eslint.setup({})
lspconfig.html.setup({})
lspconfig.jsonls.setup({})

lspconfig.ltex.setup({
    on_attach = function(client, bufnr)
        require("ltex_extra").setup({
            -- table <string> : languages for witch dictionaries will be loaded, e.g. { "es-AR", "en-US" }
            -- https://valentjn.github.io/ltex/supported-languages.html#natural-languages
            load_langs = { "en-US" }, -- en-US as default
            init_check = true,
            path = vim.fn.expand("$HOME/.tools/dicts"),
            log_level = "info",
            server_opts = nil,
        })
    end,
})

-- lspconfig.marksman.setup({})
lspconfig.pyright.setup({})
lspconfig.taplo.setup({})
lspconfig.texlab.setup({})
-- lspconfig.typos_lsp.setup({})

vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>l", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set("n", "<space>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<space>fm", function()
            vim.lsp.buf.format({ async = true })
        end, opts)
    end,
})