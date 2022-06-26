scriptencoding utf-8

if exists('g:loaded_blame_open')
    finish
endif
let g:loaded_blame_open = 1

let s:save_cpo = &cpo
set cpo&vim

" insert default value
let g:blame_open_upstream_remote = get(g:, 'blame_open_upstream_remote', 0)

command! BlameOpen lua require('blame_open').blame_open()
command! BlameOpenUrl lua require('blame_open').blame_open_url()

let &cpo = s:save_cpo
unlet s:save_cpo
