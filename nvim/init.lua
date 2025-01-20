local vim = vim

vim.g.mapleader = " "

require("vad.packages")
require("vad.filetypes")
require("vad.opts")
require("vad.treesitter")
require("vad.statusline")
require("vad.lsp")
require("vad.formatter")
require("vad.telescope")
require("vad.go")

vim.cmd([[
    " quickfix
    map <C-n> :cnext<CR>
    map <C-m> :cprevious<CR>
    nnoremap <leader>a :cclose<CR>

    silent! set mouse=nvc       " Use the mouse, but not in insert mode
    "set scrolloff=15            " Keep cursor away from this many chars top/bot
    set suffixes+=.pyc          " Ignore these files when tab-completing

    function! s:BlameToggle() abort
      let found = 0
      for winnr in range(1, winnr('$'))
        if getbufvar(winbufnr(winnr), '&filetype') ==# 'fugitiveblame'
          exe winnr . 'close'
          let found = 1
        endif
      endfor
      if !found
        Git blame
      endif
    endfunction

    nmap <silent> <M-2> :call <SID>BlameToggle()<CR>
]])

-- Emacs-like bindings in insert mode
vim.keymap.set("i", "<C-e>", "<C-o>$")
vim.keymap.set("i", "<C-a>", "<C-o>0")

-- Emacs-like bindings in the command line from `:h emacs-keys`
vim.keymap.set("c", "<C-a>", "<Home>")
vim.keymap.set("c", "<C-d>", "<Del>")

-- use Ctrl+C to copy to system clipboard in visual mode
vim.keymap.set("v", "<C-c>", '"+y')

-- -- use Ctrl+C to copy to system clipboard in visual mode
-- vmap <C-C> "+y

-- vimtree
vim.keymap.set("n", "<M-1>", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<Esc>!", ":NvimTreeFindFileToggle!<CR>")

-- whitespaces
vim.g.strip_whitespace_on_save = 1
vim.g.strip_only_modified_lines = 1
vim.g.strip_whitespace_confirm = 0
vim.g.strip_max_file_size = 10000

vim.cmd("autocmd BufWritePost ~/.Xresources silent !xrdb <afile> > /dev/null")
