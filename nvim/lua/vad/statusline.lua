local vim = vim

-- don't show "-- INSERT --" at the bottom, it's already in the statusline
vim.opt.showmode = false

require("lualine").setup({
	options = {
		globalstatus = true,
	},
})
