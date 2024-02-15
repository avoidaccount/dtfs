require("mason-tool-installer").setup({
	ensure_installed = {
		"jsonls",
		"jsonlint",
		"markdownlint",
		"prettier",
		"pyright",
		"shellharden",
		"shfmt",
		"sqlfluff",
		-- "stylua",
		"taplo",
		"write-good",
		"yamlfix",
		"yamllint",
	},

	auto_update = true,
	run_on_start = true,

	-- set a delay before the installation starts
	start_delay = 0,

	-- set time between attempts to install/update
	debounce_hours = 5,
})
