require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",

		component_separators = {
			left = "",
			right = "",
		},

		section_separators = {
			left = "",
			right = "",
		},

		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},

		always_divide_middle = true,
		globalstatus = true,

		refresh = {
			statusline = 0,
			tabline = 0,
			winbar = 0,
		},
	},

	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filetype" },
		lualine_x = {},
		lualine_y = {},
		lualine_z = { "location" },
	},

	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},

	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})
