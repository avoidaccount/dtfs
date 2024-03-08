local none = require("null-ls")

none.setup({
    sources = {
        none.builtins.code_actions.gitsigns.with({
            config = {
                filter_actions = function(title)
                    return title:lower():match("blame") == nil
                end,
            },
        }),

        -- none.builtins.code_actions.proselint,

        none.builtins.diagnostics.markdownlint.with({
            extra_args = {
                "--config",
                vim.fn.expand("$XDG_CONFIG_HOME/.utilities/markdownlint.yaml"),
            },
        }),

        -- none.builtins.diagnostics.proselint,
        none.builtins.diagnostics.selene,
        none.builtins.diagnostics.textlint,
        none.builtins.diagnostics.yamllint,

        none.builtins.formatting.markdownlint,

        none.builtins.formatting.shellharden.with({
            extra_args = { "--transform" },
            extra_filetypes = { "zsh" },
        }),

        none.builtins.formatting.shfmt.with({
            extra_filetypes = { "zsh" },
        }),

        none.builtins.formatting.stylua,
        none.builtins.formatting.textlint,
        none.builtins.formatting.yamlfix,

        none.builtins.hover.dictionary,
        none.builtins.hover.printenv,
    },
})