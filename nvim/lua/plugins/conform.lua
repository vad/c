return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_fix", "ruff_format" },
				jsonnet = { "jsonnetfmt" },
				terraform = { "terraform_fmt" },
			},
			format_on_save = {},
		},
	},
}
