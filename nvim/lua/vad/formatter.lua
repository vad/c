local vim = vim
local formatter = require("formatter")

formatter.setup({
	filetype = {
		typescriptreact = {
			-- prettier
			function()
				return {
					exe = "npx",
					args = {
						"prettier",
						"--stdin-filepath",
						vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
						"--single-quote",
					},
					stdin = true,
				}
			end,
		},
		python = {
			require("formatter.filetypes.python").black,
			require("formatter.filetypes.python").isort,
		},
		javascript = {
			require("formatter.defaults.denofmt"),
		},
		typescript = {
			require("formatter.defaults.denofmt"),
		},
		proto = {
			function()
				return {
					exe = "protolint",
					args = { "lint", "-fix", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) },
					stdin = false,
					ignore_exitcode = true,
				}
			end,
		},
		jsonnet = {
			function()
				return {
					exe = "jsonnetfmt",
					args = { "-" },
					stdin = true,
				}
			end,
		},
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
		terraform = {
			function()
				return {
					exe = "terraform",
					args = { "fmt", "-" },
					stdin = true,
				}
			end,
		},
	},
})

vim.cmd([[
    augroup FormatOnWriteAutogroup
      autocmd!
      autocmd BufWritePost *.jsonnet,*.libsonnet FormatWrite
      autocmd BufWritePost *.lua FormatWrite
      autocmd BufWritePost *.py FormatWrite
    augroup END
]])
