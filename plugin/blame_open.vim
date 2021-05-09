scriptencoding utf-8

if exists('g:loaded_blame_open')
    finish
endif
let g:loaded_blame_open = 1

let s:save_cpo = &cpo
set cpo&vim

command! BlameOpen lua require('blame_open').blame_open()

let &cpo = s:save_cpo
unlet s:save_cpo
