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
    "goolord/alpha-nvim",
    "akinsho/bufferline.nvim",
    "stevearc/dressing.nvim",
    -- "Bekaboo/dropbar.nvim",
    "edluffy/hologram.nvim",
    -- "lewis6991/satellite.nvim",
    "xiyaowong/transparent.nvim",

    "nvim-lualine/lualine.nvim",
    "nvim-tree/nvim-web-devicons",
    "dstein64/nvim-scrollview",

    "nvim-orgmode/orgmode",

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },

    "nvim-treesitter/nvim-treesitter-context",

    {
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "kdheepak/cmp-latex-symbols",
        "hrsh7th/cmp-nvim-lsp-document-symbol",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",
        "nvimtools/none-ls.nvim",
        "neovim/nvim-lspconfig",
        "NvChad/nvterm",
        "folke/trouble.nvim",
        "barreiroleo/ltex_extra.nvim",
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
    },

    "rebelot/kanagawa.nvim",
    "folke/tokyonight.nvim",

    {

        "windwp/nvim-autopairs",
        "norcalli/nvim-colorizer.lua",
        "numToStr/Comment.nvim",
        "lewis6991/gitsigns.nvim",
        "ThePrimeagen/harpoon",
        "lukas-reineke/indent-blankline.nvim",

        "tversteeg/registers.nvim",
        "kylechui/nvim-surround",

        "3rd/image.nvim",

        {
            "nvim-telescope/telescope.nvim",

            dependencies = {
                "nvim-lua/plenary.nvim",
                "debugloop/telescope-undo.nvim",
                "jvgrootveld/telescope-zoxide",
            },
        },

        "folke/zen-mode.nvim",
        "kyazdani42/nvim-tree.lua",
        "mbbill/undotree",
        "folke/which-key.nvim",
    },
}

require("lazy").setup(plugins)