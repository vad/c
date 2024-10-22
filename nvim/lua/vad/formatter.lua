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
			-- Use black when available
			function()
				if vim.fn.executable("black") == 1 then
					local util = require("formatter.util")
					return {
						exe = "black",
						args = { "-q", "--stdin-filename", util.escape_path(util.get_current_buffer_file_name()), "-" },
						stdin = true,
					}
				end
			end,
			-- Use ruff when available
			function()
				if vim.fn.executable("ruff") == 1 then
					return {
						exe = "ruff",
						args = { "check", "--fix", "--exit-zero", "--stdin-filename", "%:p" },
						stdin = true,
					}
				end
			end,
			function()
				if vim.fn.executable("ruff") == 1 then
					return {
						exe = "ruff",
						args = { "format", "--stdin-filename", "%:p" },
						stdin = true,
					}
				end
			end,
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
      autocmd BufWritePost *.tf FormatWrite
    augroup END
]])
