require("tokyonight").setup({
    -- storm, night and moon
    style = "night",
    light_style = "day",
    transparent = true,
    terminal_colors = true,

    styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = { bold = true },
        variables = { bold = true },
        sidebars = "dark",
        floats = "dark",
    },

    sidebars = { "qf", "help" },

    day_brightness = 0.3,
    hide_inactive_statusline = true,
    dim_inactive = true,
    lualine_bold = true,
})
vim.cmd.colorscheme("tokyonight")
