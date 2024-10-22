local vim = vim

-- jsonnet
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.jsonnet", "*.libsonnet" },
	callback = function()
		vim.opt_local.filetype = "jsonnet"
	end,
})

-- Ansible
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*/ansible/*.yml", "*/ansible-pull/*.yml" },
	callback = function()
		vim.opt_local.filetype = "yaml.ansible"
	end,
})

-- cloudformation templates are json
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.template" },
	callback = function()
		vim.opt_local.filetype = "json"
		vim.opt_local.sw = 2
		vim.opt_local.ts = 2
		vim.opt_local.expandtab = true
	end,
})

-- systemd filetypes
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = {
		"*.automount",
		"*.mount",
		"*.path",
		"*.service",
		"*.socket",
		"*.swap",
		"*.target",
		"*.timer",
	},
	callback = function()
		vim.opt_local.filetype = "systemd"
	end,
})

-- logstash with jinja2
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*logstash/*.conf.j2" },
	callback = function()
		vim.opt_local.filetype = "logstash.jinja2"
	end,
})
