require("neorg").setup({
    load = {
        ["core.defaults"] = {},

        ["core.completion"] = {
            config = {
                engine = "nvim-cmp",
                name = "[Neorg]",
            },
        },

        ["core.concealer"] = {
            config = {
                icon_preset = "diamond",
            },
        },

        ["core.dirman"] = {
            config = {
                workspaces = {
                    knowlegdebase = "$HOME/wikimyro",
                },

                default_workspace = "knowlegdebase",
            },
        },

        ["core.export"] = {},

        ["core.export.markdown"] = {
            config = {
                extensions = "all",
            },
        },

        ["core.presenter"] = {
            config = {
                zen_mode = "zen-mode",
            },
        },

        ["core.summary"] = {},
    },
})
