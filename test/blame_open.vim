" themis spec
"
let s:suite = themis#suite('blame_open')
let s:assert = themis#helper('assert')

function! s:suite.success_test()
  call s:assert.equals(3, 3)
endfunction

" vspec spec
" describe 'example test'
"   it '1 + 1 = 2'
"     Expect 1 + 1 == 2
"   end
" end
