local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local telescope = require("telescope")
local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")

vim.keymap.set("n", "<leader>t", builtin.git_files, {})
vim.keymap.set("n", "<leader>T", builtin.find_files, {})
vim.keymap.set("n", "<leader><leader>", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
vim.keymap.set("n", "<M-k>", live_grep_args_shortcuts.grep_word_under_cursor)
vim.keymap.set("n", "<leader>;", builtin.buffers, {})
vim.keymap.set("n", "<leader>re", builtin.resume, {})
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {})
vim.keymap.set("n", "gr", builtin.lsp_references, {})
vim.keymap.set("n", "gd", builtin.lsp_definitions, {})
vim.keymap.set("n", "<leader>gb", builtin.git_branches, {})
vim.keymap.set("n", "<leader>gc", builtin.git_bcommits, {})
vim.keymap.set("v", "<leader>gc", builtin.git_bcommits_range, {})

telescope.setup({
	defaults = {
		layout_strategy = "vertical",
		mappings = {
			i = {
				["<esc>"] = actions.close,
				["<Tab>"] = actions.toggle_selection,
				["<c-t>"] = require("trouble.sources.telescope").open,
			},
			n = { ["<c-t>"] = require("trouble.sources.telescope").open },
		},
	},
})
