local vim = vim

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = { -- import your plugins
		{ import = "plugins" },

		{
			"rebelot/kanagawa.nvim",
			priority = 1000,
			config = function()
				require("kanagawa").setup({
					background = { -- map the value of 'background' option to a theme
						dark = "wave", -- try "dragon" !
						light = "lotus",
					},
				})

				-- setup must be called before loading
				vim.cmd("colorscheme kanagawa")
			end,
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
		{
			"ray-x/go.nvim",
			dependencies = { -- optional packages
				"ray-x/guihua.lua",
				"neovim/nvim-lspconfig",
				"nvim-treesitter/nvim-treesitter",
			},
			config = function()
				require("go").setup()
			end,
			event = { "CmdlineEnter" },
			ft = { "go", "gomod" },
			build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
		},
		"robbles/logstash.vim",
		"uarun/vim-protobuf",
		"ziglang/zig.vim",
		"towolf/vim-helm",

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
	},
})
