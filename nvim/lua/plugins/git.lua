return {
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
		config = function()
			vim.g.fugitive_gitlab_domains = { "https://scanzia.spaziodati.eu" }
		end,
	},
}
