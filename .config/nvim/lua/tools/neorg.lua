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
                    default = "/storage/emulated/0/wikimyro",
                },

                index = "index.norg",
            },
        },

        ["core.export"] = {},

        ["core.summary"] = {},
    },
})