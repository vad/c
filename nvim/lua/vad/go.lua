-- go shortcuts

vim.cmd [[
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
]]


-- goimports on save
vim.g.go_fmt_command = "goimports"

-- let LSP handle gd
vim.g.go_def_mapping_enabled = 0
