local vim = vim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			vim.cmd.colorscheme("gruvbox")
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},

	{
		"tpope/vim-fugitive",
		dependencies = { "shumphrey/fugitive-gitlab.vim" },
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	"ntpeters/vim-better-whitespace",

	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({
				disable_netrw = false,
				hijack_netrw = true,
			})
		end,
	},

	{
		"tpope/vim-surround",
		dependencies = { "tpope/vim-repeat" },
	},

	"vim-scripts/restore_view.vim",

	"tpope/vim-commentary",

	-- filetypes
	"pearofducks/ansible-vim",
	"amadeus/vim-mjml",
	"hashivim/vim-terraform",
	"fatih/vim-go",
	"robbles/logstash.vim",
	"uarun/vim-protobuf",
	"ziglang/zig.vim",

	-- lsp
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",

	-- Install nvim-cmp
	"hrsh7th/nvim-cmp",
	-- Install snippet engine (This example installs [hrsh7th/vim-vsnip](https://github.com/hrsh7th/vim-vsnip))
	"hrsh7th/cmp-vsnip",
	"hrsh7th/vim-vsnip",
	"hrsh7th/vim-vsnip-integ",

	-- Install the buffer completion source
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-nvim-lua",
	"ray-x/cmp-treesitter",
	"f3fora/cmp-spell",

	-- This tiny plugin adds vscode-like pictograms to neovim built-in lsp
	"onsails/lspkind-nvim",

	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	"nvim-treesitter/playground",
	"nvim-treesitter/nvim-treesitter-textobjects",
	"nvim-treesitter/nvim-treesitter-context",

	{ "mhartington/formatter.nvim" },

	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
		},
	},
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

	{ "j-hui/fidget.nvim", tag = "legacy" },

	"dstein64/vim-startuptime",
})
