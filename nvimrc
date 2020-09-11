call plug#begin('~/.local/share/nvim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'mileszs/ack.vim'

"Plug 'tomasr/molokai'
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

"Plug 'nvie/vim-flake8'

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

Plug 'neoclide/coc.nvim', {'branch': 'release'}

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
let g:ansible_unindent_after_newline = 1

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
nmap <silent> <Esc>a :CocAction<CR>
nmap <silent> <space><space> :CocList symbols<CR>

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
function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction
let g:lightline = {
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'colorscheme': 'gruvbox',
    \ 'component_function': {
    \   'cocstatus': 'coc#status',
    \   'currentfunction': 'CocCurrentFunction'
    \ },
\ }

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

" let coc handle gd
let g:go_def_mapping_enabled = 0

" ===================== COC ===================
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Make <tab> used for trigger completion, completion confirm, snippet expand and jump
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search snippets
nnoremap <silent> <space>s  :<C-u>CocList snippets<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" END COC --------------

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
