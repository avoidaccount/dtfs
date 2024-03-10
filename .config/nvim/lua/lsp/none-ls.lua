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

        none.builtins.diagnostics.markdownlint,
        none.builtins.diagnostics.selene,
        none.builtins.diagnostics.textlint,
        none.builtins.diagnostics.yamllint,
        none.builtins.diagnostics.zsh,

        none.builtins.formatting.markdownlint,

        none.builtins.formatting.shellharden.with({
            extra_args = { "--transform" },
            extra_filetypes = { "zsh" },
        }),

        none.builtins.formatting.shfmt.with({ extra_filetypes = { "zsh" } }),

        none.builtins.formatting.stylua,
        none.builtins.formatting.textlint,
        none.builtins.formatting.yamlfix,

        none.builtins.hover.dictionary,
        none.builtins.hover.printenv,
    },

    debug = true,
    temp_dir = vim.fn.expand("~/.local/share/nvim/tmp_none-ls"),
})