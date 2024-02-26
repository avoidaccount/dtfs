local none = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

none.setup({
    sources = {
        none.builtins.code_actions.gitsigns.with({
            config = {
                filter_actions = function(title)
                    return title:lower():match("blame") == nil
                end,
            },
        }),

        none.builtins.code_actions.proselint.with({
            extra_filetypes = {
                "norg",
            },
        }),

        none.builtins.diagnostics.markdownlint,

        none.builtins.diagnostics.proselint.with({
            extra_filetypes = {
                "norg",
            },
        }),

        none.builtins.diagnostics.selene,
        none.builtins.diagnostics.yamllint,

        none.builtins.formatting.markdownlint.with({
            extra_args = {
                "--config",
                vim.fn.expand("$XDG_CONFIG_HOME/fmtlnt/markdownlint.yaml"),
            },
        }),

        none.builtins.formatting.prettier.with({
            extra_args = {
                "--config",
                vim.fn.expand("$XDG_CONFIG_HOME/fmtlnt/prettierrc.yaml"),
            },
        }),

        none.builtins.formatting.shellharden.with({
            extra_filetypes = {
                "zsh",
            },
        }),

        none.builtins.formatting.stylua,
        none.builtins.formatting.yamlfix,

        none.builtins.hover.dictionary,
        none.builtins.hover.printenv,
    },

    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ async = false })
                end,
            })
        end
    end,
})