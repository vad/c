local opt = vim.opt

opt.compatible = false

opt.number = true
opt.relativenumber = true

opt.termguicolors = true
vim.cmd.colorscheme("gruvbox")

opt.expandtab = true
opt.list = true

opt.hlsearch = true         -- Hilight searching
opt.ignorecase = true       -- Case insensitive
opt.incsearch = true        -- Search as you type
opt.infercase = true        -- Completion recognizes capitalization

opt.shiftwidth = 4
opt.tabstop = 4

-- folding
opt.foldmethod = "indent"
opt.foldlevelstart = 99
