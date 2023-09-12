local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local telescope = require("telescope")

vim.keymap.set("n", "<leader>t", builtin.git_files, {})
vim.keymap.set("n", "<leader>T", builtin.find_files, {})
-- vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
vim.keymap.set("n", "<leader>g", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
vim.keymap.set("n", "<M-k>", builtin.grep_string, {})
vim.keymap.set("n", "<leader>;", builtin.buffers, {})
vim.keymap.set("n", "<leader>re", builtin.resume, {})
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {})

telescope.load_extension("fzf")
telescope.load_extension("live_grep_args")

telescope.setup({
	defaults = {
		layout_strategy = "vertical",
		mappings = {
			i = {
				["<esc>"] = actions.close,
				["<Tab>"] = actions.toggle_selection,
			},
		},
	},
})
