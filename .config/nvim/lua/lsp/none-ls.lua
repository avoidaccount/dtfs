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

        none.builtins.code_actions.proselint.with({
            extra_filetypes = {
                "norg",
            },
        }),

        none.builtins.diagnostics.editorconfig_checker,
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

        none.builtins.formatting.shellharden.with({
            extra_args = {
                "--transform",
            },

            extra_filetypes = {
                "zsh",
            },
        }),

        none.builtins.formatting.shfmt.with({
            extra_filetypes = {
                "zsh",
            },
        }),

        none.builtins.formatting.stylua,
        none.builtins.formatting.yamlfix,

        none.builtins.hover.dictionary.with({
            extra_filetypes = {
                "norg",
            },
        }),

        none.builtins.hover.printenv,
    },
})
