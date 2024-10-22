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
			-- require("scrollbar.handlers.gitsigns").setup()
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

	-- disabilitato perché scazza la current working directory
	-- "vim-scripts/restore_view.vim",

	-- filetypes
	"pearofducks/ansible-vim",
	"amadeus/vim-mjml",
	"hashivim/vim-terraform",
	"fatih/vim-go",
	"robbles/logstash.vim",
	"uarun/vim-protobuf",
	"ziglang/zig.vim",
	"towolf/vim-helm",

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
	{ "rafamadriz/friendly-snippets" },

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
		config = function()
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("live_grep_args")
		end,
	},
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

	"dstein64/vim-startuptime",

	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = "Trouble",
		config = function()
			vim.keymap.set("n", "<leader>xx", function()
				require("trouble").open()
			end)
			vim.keymap.set("n", "<leader>xw", function()
				require("trouble").open("workspace_diagnostics")
			end)
			vim.keymap.set("n", "<leader>xd", function()
				require("trouble").open("document_diagnostics")
			end)
			vim.keymap.set("n", "<leader>xq", function()
				require("trouble").open("quickfix")
			end)
			vim.keymap.set("n", "<leader>xl", function()
				require("trouble").open("loclist")
			end)
			vim.keymap.set("n", "gR", function()
				require("trouble").open("lsp_references")
			end)
			vim.keymap.set("n", "<leader>n", function()
				require("trouble").next({ skip_groups = true, jump = true })
			end)
			vim.keymap.set("n", "<leader>p", function()
				require("trouble").previous({ skip_groups = true, jump = true })
			end)

			vim.keymap.set("n", "<M-3>", ":TroubleToggle<CR>")
		end,
	},

	-- DISABLED BECAUSE OF https://github.com/petertriho/nvim-scrollbar/issues/99
	-- {
	-- 	"petertriho/nvim-scrollbar",
	-- 	config = function()
	-- 		require("scrollbar").setup()
	-- 	end,
	-- },
	-- {
	-- 	"kevinhwang91/nvim-hlslens",
	-- 	config = function()
	-- 		-- require('hlslens').setup() is not required
	-- 		require("scrollbar.handlers.search").setup({
	-- 			-- hlslens config overrides
	-- 		})
	-- 	end,
	-- },
	{
		"nvim-pack/nvim-spectre",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = {
			vim.keymap.set("n", "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', {
				desc = "Toggle Spectre",
			}),
		},
	},
	{
		"DanieleIsoni/py-package-info.nvim",
		config = {
			vim.api.nvim_set_keymap(
				"n",
				"<leader>ps",
				"<cmd>lua require('py-package-info').show()<cr>",
				{ silent = true, noremap = true }
			),
		},
	},
})
