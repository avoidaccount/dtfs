require("neorg").setup({
    load = {
        ["core.defaults"] = {},

        ["core.completion"] = {
            config = {
                engine = "nvim-cmp",
                name = "[Neorg]",
            },
        },

        ["core.concealer"] = {},

        ["core.dirman"] = {
            config = {
                workspaces = {
                    knowlegdebase = "$HOME/wikimyro",
                },

                default_workspace = "knowlegdebase",
            },
        },

        ["core.export"] = {},
        ["core.export.markdown"] = {},

        ["core.presenter"] = {
            config = {
                zen_mode = "zen-mode",
            },
        },

        ["core.summary"] = {},
    },
})
