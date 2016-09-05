
function! s:InsertGuard()
  execute "normal! i#pragma once"
endfunction

augroup insert_c_cpp_objc_header_guard
  autocmd!
  autocmd BufNewFile *.{h,hpp} call <SID>InsertGuard()
augroup END
