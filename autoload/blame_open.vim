scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

" do something

let &cpo = s:save_cpo
unlet s:save_cpo
