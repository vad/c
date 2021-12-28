" vim-plug
call plug#begin('~/.local/share/nvim3/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'mileszs/ack.vim'

Plug 'morhetz/gruvbox'

Plug 'airblade/vim-gitgutter'

Plug 'tpope/vim-fugitive'
Plug 'shumphrey/fugitive-gitlab.vim'

Plug 'itchyny/lightline.vim'

" { 'do': ':GoUpdateBinaries' }
Plug 'fatih/vim-go'

Plug 'pearofducks/ansible-vim'

Plug 'ntpeters/vim-better-whitespace'

Plug 'martinda/Jenkinsfile-vim-syntax'

Plug 'scrooloose/nerdtree'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

Plug 'google/vim-jsonnet'

Plug 'vim-scripts/restore_view.vim'

Plug 'amadeus/vim-mjml'

Plug 'tpope/vim-commentary'

Plug 'hashivim/vim-terraform'

Plug 'cespare/vim-toml'

Plug 'robbles/logstash.vim'

Plug 'uarun/vim-protobuf'

" lsp
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'

" Install nvim-cmp
Plug 'hrsh7th/nvim-cmp'
" Install snippet engine (This example installs [hrsh7th/vim-vsnip](https://github.com/hrsh7th/vim-vsnip))
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" Install the buffer completion source
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'ray-x/cmp-treesitter'
Plug 'f3fora/cmp-spell'

Plug 'onsails/lspkind-nvim'

Plug 'easymotion/vim-easymotion'

" Plug 'vim-test/vim-test'

Plug 'ziglang/zig.vim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

Plug 'mhartington/formatter.nvim'

" Initialize plugin system
call plug#end()

" ------------------------------------------------------------------------

set nocompatible
" set t_Co=256

set number
set relativenumber

set termguicolors
" let g:rehash256 = 1
" let g:molokai_original = 1
" colorscheme molokai
colorscheme gruvbox

" ~/.viminfo needs to be writable and readable. Set oldfiles to 1000 last
" recently opened files, :History uses it
set viminfo='1000

nmap <Leader>; :Buffers<CR>
nmap <Leader>t :GFiles<CR>
nmap <Leader>r :Tags<CR>

nmap <M-k>    :Ack! "\b<cword>\b" <CR>
nmap <Esc>k   :Ack! "\b<cword>\b" <CR>

" use 'ag' instead of 'ack'
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Emacs-like bindings in insert mode
imap <C-e> <C-o>$
imap <C-a> <C-o>0

" Emacs-like bindings in the command line from `:h emacs-keys`
cnoremap <C-a>  <Home>
cnoremap <C-b>  <Left>
cnoremap <C-f>  <Right>
cnoremap <C-d>  <Del>
cnoremap <C-e>  <End>
cnoremap <M-b>  <S-Left>
cnoremap <M-f>  <S-Right>
cnoremap <M-d>  <S-right><Delete>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>
cnoremap <Esc>d <S-right><Delete>
cnoremap <C-g>  <C-c>

" Use the space key to toggle folds
"nnoremap <space> za
"vnoremap <space> zf

" folding
set foldmethod=indent
" set foldcolumn=1
set foldlevelstart=99

" use Ctrl+C to copy to system clipboard in visual mode
vmap <C-C> "+y

" YAML
autocmd FileType yaml set sw=2

" Ansible
au BufRead,BufNewFile */ansible/*.yml set filetype=yaml.ansible
au BufRead,BufNewFile */ansible-pull/*.yml set filetype=yaml.ansible
" let g:ansible_unindent_after_newline = 1

" quickfix
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

set hlsearch                " Hilight searching
set ignorecase              " Case insensitive
set incsearch               " Search as you type
set infercase               " Completion recognizes capitalization
silent! set mouse=nvc       " Use the mouse, but not in insert mode
"set scrolloff=15            " Keep cursor away from this many chars top/bot
set suffixes+=.pyc          " Ignore these files when tab-completing

set ts=4
set sw=4


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

nmap <M-1>    :NERDTreeToggle<CR>
nmap <Esc>1    :NERDTreeToggle<CR>
nmap <Esc>!    :NERDTreeFind<CR>
nmap <leader>1    :NERDTreeFind<CR>
nmap <silent> <M-2> :call <SID>BlameToggle()<CR>

" cloudformation templates are json
autocmd BufNewFile,BufRead *.template   set ft=json sw=2 ts=2 expandtab

set expandtab
set list

set viewoptions=cursor,folds,slash,unix
" let g:skipview_files = ['*\.vim']

" systemd filetypes
au BufNewFile,BufRead *.automount set filetype=systemd
au BufNewFile,BufRead *.mount     set filetype=systemd
au BufNewFile,BufRead *.path      set filetype=systemd
au BufNewFile,BufRead *.service   set filetype=systemd
au BufNewFile,BufRead *.socket    set filetype=systemd
au BufNewFile,BufRead *.swap      set filetype=systemd
au BufNewFile,BufRead *.target    set filetype=systemd
au BufNewFile,BufRead *.timer     set filetype=systemd

let g:python_host_prog='/usr/bin/python3'

let g:strip_whitespace_on_save = 1
let g:strip_only_modified_lines = 1
let g:strip_whitespace_confirm = 0
let g:strip_max_file_size = 10000

"=================== PLUGINS ====================

" =================== FUGITIVE ==================
let g:fugitive_gitlab_domains = ['https://scanzia.spaziodati.eu']

" ================== GIT-GUTTER =================
set updatetime=250

" ================== LIGHTLINE ==================
set laststatus=2
set noshowmode " don't show -- INSERT -- at the bottom, it's already in the statusline

" ===================== GO ====================

" go shortcuts
augroup go
    autocmd!

    autocmd FileType go nmap <leader>b  <Plug>(go-build)
    autocmd FileType go nmap <leader>r  <Plug>(go-run)

    autocmd FileType go nmap <silent> <Leader>l <Plug>(go-metalinter)
    autocmd FileType go nmap <silent> <Leader>c <Plug>(go-coverage-toggle)
    autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
    autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
    autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
augroup END

" goimports on save
let g:go_fmt_command = "goimports"

" let LSP handle gd
let g:go_def_mapping_enabled = 0

" ==================== FZF ====================
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let g:fzf_layout = { 'down': '~20%' }

nnoremap <leader>or  :History<CR>

autocmd BufWritePost ~/.Xresources silent !xrdb <afile> > /dev/null

" vim-test
let test#python#runner = 'pytest'
" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

" zig
"au BufRead,BufNewFile *.zig    setfiletype zig

" treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { "zig" },
  highlight = {
    enable = true
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
        ["as"] = "@statement.outer"
      }
    }
  },
}
EOF

" LSP
lua <<EOF
require'lspconfig'.pyright.setup{}

-- cmp
local cmp = require'cmp'

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

cmp.setup {
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    formatting = {
        format = function(entry, vim_item)
            -- fancy icons and a name of kind
            vim_item.kind = require("lspkind").presets.default[vim_item.kind] ..
            " " .. vim_item.kind
            -- set a name for each source
            vim_item.menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                ultisnips = "[UltiSnips]",
                nvim_lua = "[Lua]",
                cmp_tabnine = "[TabNine]",
                look = "[Look]",
                path = "[Path]",
                spell = "[Spell]",
                calc = "[Calc]",
                emoji = "[Emoji]"
            })[entry.source.name]
            return vim_item
        end
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<Tab>'] = cmp.mapping.confirm({select = true}),
        ['<CR>'] = cmp.mapping.confirm({select = true}),
--      ["<Tab>"] = cmp.mapping(function(fallback)
--          if vim.fn.pumvisible() == 1 then
--              vim.fn.feedkeys(t("<C-n>"), "n")
--          elseif check_back_space() then
--              vim.fn.feedkeys(t("<tab>"), "n")
--          else
--              fallback()
--          end
--      end, {"i", "s"}),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if vim.fn.pumvisible() == 1 then
                vim.fn.feedkeys(t("<C-p>"), "n")
            else
                fallback()
            end
        end, {"i", "s"})
    },
    sources = {
        {name = 'nvim_lsp'},
        {name = 'vsnip' },
        {name = "path"},
        {name = "treesitter"},
        {name = "nvim_lua"},
        {name = "spell"},
        -- buffer can be slow, ocio!
        {name = 'buffer', keyword_length = 5},
    },
    completion = {completeopt = 'menu,menuone,noinsert'},
    experimental = {
        native_menu = false,
        ghost_text = true,
    }
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    --Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    buf_set_keymap("n", "<space>ll", "<cmd>lua vim.lsp.log.get_filename()<CR>", opts)

end

local lsp_installer = require("nvim-lsp-installer")

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = on_attach,
        capabilities = capabilities,
    }

    if server.name == "tsserver" then
        opts.root_dir = nvim_lsp.util.root_pattern("package.json")
    end

    if server.name == "denols" then
        opts.root_dir = nvim_lsp.util.root_pattern("deno.json")
    end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)
EOF


" formatter
lua <<EOF
local vim = vim
local formatter = require("formatter")

formatter.setup({
    filetype = {
        typescriptreact = {
            -- prettier
            function()
                return {
                    exe = "prettier",
                    args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--single-quote'},
                    stdin = true
                }
            end
        },
        python = {
            -- Configuration for psf/black
            function()
                return {
                    exe = "black", -- this should be available on your $PATH
                    args = { '-' },
                    stdin = true,
                }
            end
        },
        typescript = {
            function()
                return {
                    exe = "deno",
                    args = { "fmt", "-" },
                    stdin = true,
                }
            end
        }
    }
})
EOF
