require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"bash",
		"c",
		"comment",
		"css",
		"gpg",
		"git_config",
		"gitattributes",
		"gitcommit",
		"gitignore",
		"html",
		"http",
		"latex",
		"lua",
		"ini",
		"javascript",
		"json",
		"jsonc",
		"markdown",
		"markdown_inline",
		"norg",
		"python",
		"query",
		"rust",
		"ssh_config",
		"toml",
		"yaml",
	},

	highlight = {
		enable = true,
		use_languagetree = true,
	},

	indent = {
		enable = true,
	},

	sync_install = true,
})
