local vim = vim

-- don't show "-- INSERT --" at the bottom, it's already in the statusline
vim.opt.showmode = false
vim.opt.laststatus = 3

require("lualine").setup({
	options = {
		globalstatus = true,
	},
})
