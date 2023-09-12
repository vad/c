local vim = vim

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packages.lua source <afile> | PackerCompile
  augroup end
]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	use({ "ellisonleao/gruvbox.nvim" }) -- lua version, faster

	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	})

	use({
		"tpope/vim-fugitive",
		requires = { "shumphrey/fugitive-gitlab.vim" },
	})

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons" },
	})

	use("ntpeters/vim-better-whitespace")

	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({
				disable_netrw = false,
				hijack_netrw = true,
			})
		end,
	})

	use({
		"tpope/vim-surround",
		requires = { "tpope/vim-repeat" },
	})

	use("vim-scripts/restore_view.vim")

	use("tpope/vim-commentary")

	-- filetypes
	use("pearofducks/ansible-vim")
	use("amadeus/vim-mjml")
	use("hashivim/vim-terraform")
	use("fatih/vim-go")
	use("robbles/logstash.vim")
	use("uarun/vim-protobuf")
	use("ziglang/zig.vim")

	-- lsp
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("neovim/nvim-lspconfig")

	-- Install nvim-cmp
	use("hrsh7th/nvim-cmp")
	-- Install snippet engine (This example installs [hrsh7th/vim-vsnip](https://github.com/hrsh7th/vim-vsnip))
	use("hrsh7th/cmp-vsnip")
	use("hrsh7th/vim-vsnip")
	use("hrsh7th/vim-vsnip-integ")

	-- Install the buffer completion source
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-nvim-lua")
	use("ray-x/cmp-treesitter")
	use("f3fora/cmp-spell")

	-- This tiny plugin adds vscode-like pictograms to neovim built-in lsp
	use("onsails/lspkind-nvim")

	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("nvim-treesitter/playground")
	use("nvim-treesitter/nvim-treesitter-textobjects")
	use("nvim-treesitter/nvim-treesitter-context")

	use({ "mhartington/formatter.nvim" })

	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
		},
	})
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	use({ "j-hui/fidget.nvim", tag = "legacy" })

	use({ "dstein64/vim-startuptime" })
end)
