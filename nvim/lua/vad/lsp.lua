local vim = vim

require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = {
		"bashls",
		"denols",
		"gopls",
		"jsonnet_ls",
		"lua_ls",
		"pyright",
		"ruff",
		"terraformls",
		"vimls",
		"clangd",
	},
	automatic_enable = true,
})

vim.lsp.config.jsonnet_ls = {
	cmd = {
		"jsonnet-language-server",
		"--jpath",
		"/home/vad/Source/SpazioDati/pimento/k8s-libs",
	},
}

vim.lsp.config.denols = {
	root_markers = { "deno.json", "deno.jsonc", "denops" },
}

vim.lsp.config.tsserver = {
	root_markers = { "package.json" },
}

-- required until jsonnet_ls is removed from https://github.com/neovim/nvim-lspconfig/issues/3705
require("lspconfig").jsonnet_ls.setup({})

-- cmp
local cmp = require("cmp")

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	formatting = {
		format = require("lspkind").cmp_format({
			mode = "symbol", -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

			-- The function below will be called before any actual modifications from lspkind
			-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
			-- before = function (entry, vim_item)
			--   ...
			--   return vim_item
			-- end
		}),
	},
	mapping = {
		-- ["<C-p>"] = cmp.mapping.select_prev_item(),
		-- ["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.confirm({ select = true })
			elseif vim.fn["vsnip#available"](1) == 1 then
				feedkey("<Plug>(vsnip-expand-or-jump)", "")
			elseif has_words_before() then
				cmp.complete()
			else
				fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function()
			if vim.fn["vsnip#jumpable"](-1) == 1 then
				feedkey("<Plug>(vsnip-jump-prev)", "")
			end
		end, { "i", "s" }),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Down>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
		["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
		-- ["<A-y>"] = require("minuet").make_cmp_map(),
	},
	sources = {
		{ name = "nvim_lsp" },
		-- { name = "vsnip" },  -- gives errors in terraform files
		{ name = "path" },
		{ name = "treesitter" },
		{ name = "nvim_lua" },
		{ name = "spell" },

		-- this would add minuet to standard cmp completion. I prefer to trigger it with a special mapping instead
		-- { name = "minuet" },

		-- buffer can be slow, ocio!
		{
			name = "buffer",
			option = {
				get_bufnrs = function() -- visible buffers
					local bufs = {}
					for _, win in ipairs(vim.api.nvim_list_wins()) do
						bufs[vim.api.nvim_win_get_buf(win)] = true
					end
					return vim.tbl_keys(bufs)
				end,
			},
			keyword_length = 3,
		},
	},
	completion = { completeopt = "menu,menuone,noinsert" },
	experimental = {
		native_menu = false,
		ghost_text = true,
	},
})

-- keep as a reference. See default ones at https://gpanders.com/blog/whats-new-in-neovim-0-11/#more-default-mappings
-- 	-- See `:help vim.lsp.*` for documentation on any of the below functions
-- 	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
-- 	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
-- 	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
-- 	buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
-- 	buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
-- 	buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
-- 	buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
-- 	buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
-- 	buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
-- 	-- buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
-- 	buf_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
-- 	buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
-- 	buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
-- 	buf_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
-- 	buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
--
-- 	buf_set_keymap("n", "<leader>L", "<cmd>lua vim.lsp.codelens.run()<CR>", opts)
-- end

vim.diagnostic.config({
	--- virtual_lines creates fake lines below the error
	virtual_lines = true,
	--- virtual_text shows errors on the same line
	-- virtual_text = {
	-- 	-- show which LSP is giving the diagnostic
	-- 	source = true,
	-- },
})
