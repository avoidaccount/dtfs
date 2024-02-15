require("catppuccin").setup({
	-- latte, frappe, macchiato, mocha
	flavour = "mocha",

	background = {
		light = "latte",
		dark = "mocha",
	},

	-- disables setting the background color.
	transparent_background = true,
	-- shows the '~' characters after the end of buffers
	show_end_of_buffer = true,
	-- sets terminal colors (e.g. `g:terminal_color_0`)
	term_colors = true,

	dim_inactive = {
		-- dims the background color of inactive window
		enabled = true,
		shade = "dark",
		-- percentage of the shade to apply to the inactive window
		percentage = 0.15,
	},

	-- Force no italic
	no_italic = false,
	-- Force no bold
	no_bold = false,
	-- Force no underline
	no_underline = false,

	styles = {
		-- Change the style of comments
		comments = { "italic" },
		conditionals = { "italic" },
		loops = {},
		functions = { "bold" },
		keywords = { "bold" },
		strings = {},
		variables = {},
		numbers = { "underline" },
		booleans = { "bold" },
		properties = { "bold" },
		types = { "bold" },
		operators = { "bold" },
	},

	color_overrides = {},

	custom_highlights = {},

	integrations = {
		alpha = true,
		cmp = true,
		dashboard = true,

		dropbar = {
			enabled = true,
			color_mode = true, -- enable color for kind's texts, not just kind's icons
		},

		indent_blankline = {
			enabled = true,
			scope_color = "lavender", -- catppuccin color (eg. `lavender`) Default: text
			colored_indent_levels = true,
		},

		markdown = true,
		mason = true,
		mini = true,

		native_lsp = {
			enabled = true,

			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
			},

			underlines = {
				errors = { "underline" },
				hints = { "underline" },
				warnings = { "underline" },
				information = { "underline" },
			},

			inlay_hints = {
				background = true,
			},
		},

		notify = true,
		nvimtree = true,
		telescope = true,
		treesitter = true,
		which_key = true,
	},
})

-- setup must be called before loading
vim.cmd.colorscheme("catppuccin")
