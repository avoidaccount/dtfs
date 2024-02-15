local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	{
		"goolord/alpha-nvim",
		"akinsho/bufferline.nvim",
		"stevearc/dressing.nvim",
		-- "Bekaboo/dropbar.nvim",
		"edluffy/hologram.nvim",
		-- "lewis6991/satellite.nvim",
		"xiyaowong/transparent.nvim",

		{
			"nvim-lualine/lualine.nvim",
			dependencies = {
				"nvim-tree/nvim-web-devicons",
			},
		},

		"dstein64/nvim-scrollview",

		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
		},
	},

	{
		{
			"hrsh7th/nvim-cmp",
			dependencies = {
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline",
				"hrsh7th/cmp-vsnip",
				"hrsh7th/vim-vsnip",
				"saadparwaiz1/cmp_luasnip",
				"rafamadriz/friendly-snippets",
				{
					"L3MON4D3/LuaSnip",
					build = "make install_jsregexp",
				},
			},
		},

		"nvimtools/none-ls.nvim",
		"neovim/nvim-lspconfig",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"NvChad/nvterm",
		"folke/trouble.nvim",
	},

	{
		{
			"catppuccin/nvim",
			name = "catppuccin",
		},

		"rebelot/kanagawa.nvim",
		"navarasu/onedark.nvim",
		"folke/tokyonight.nvim",
		priority = 1000,
	},

	{
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
		},

		"norcalli/nvim-colorizer.lua",
		"numToStr/Comment.nvim",
		"lewis6991/gitsigns.nvim",
		"ThePrimeagen/harpoon",
		"lukas-reineke/indent-blankline.nvim",

		{
			"iamcco/markdown-preview.nvim",

			cmd = {
				"MarkdownPreviewToggle",
				"MarkdownPreview",
				"MarkdownPreviewStop",
			},

			ft = {
				"markdown",
			},

			build = function()
				vim.fn["mkdp#util#install"]()
			end,
		},

		"tversteeg/registers.nvim",
		"kylechui/nvim-surround",

		{
			"nvim-neorg/neorg",
			build = ":Neorg sync-parsers",
			dependencies = {
				"3rd/image.nvim",
			},
		},

		{
			"nvim-telescope/telescope.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"jvgrootveld/telescope-zoxide",
			},
		},

		"kyazdani42/nvim-tree.lua",
		"mbbill/undotree",
		"folke/which-key.nvim",
	},
}

require("lazy").setup(plugins)
