require("nvim-treesitter.configs").setup({
	ensure_installed = { "go", "python", "lua", "markdown" },
	sync_install = false,
	auto_install = false,
	ignore_install = { "zig" },
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- automatically jump forward to matching textobj
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["aP"] = "@parameter.outer",
				["as"] = "@statement.outer",
			},
		},
	},
})
