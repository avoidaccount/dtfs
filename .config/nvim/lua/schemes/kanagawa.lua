require("kanagawa").setup({
    -- enable compiling the colorscheme
    compile = true,
    -- enable undercurls
    undercurl = true,

    commentStyle = { italic = true },
    functionStyle = { bold = true },
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = { italic = true },

    transparent = true,
    -- dim inactive window
    dimInactive = true,
    terminalColors = true,

    colors = {
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
    },

    overrides = function(colors)
        return {}
    end,

    -- Load "wave" theme when 'background' option is not set
    theme = "wave",

    -- map the value of 'background' option to a theme
    background = {
        dark = "dragon",
        light = "lotus",
    },
})

vim.cmd.colorscheme("kanagawa")