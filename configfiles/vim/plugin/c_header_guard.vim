

function! s:insert_guards()
  let guardname = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  let id = substitute(system("uuidgen"), "[-\n]", "", "g")
  let guardname = guardname . "__" . id
  execute "normal! i/* vim: set filetype=" . &filetype . ": */"
  execute "normal! o#ifndef " . guardname
  execute "normal! o#define " . guardname
  execute "normal! o"
  execute "normal! o"
  execute "normal! o"
  execute "normal! Go#endif /* " . guardname . " */"
  normal! kk
endfunction


augroup insert_c_cpp_objc_header_guard
  autocmd!
  autocmd BufNewFile *.{h,hpp} call <SID>insert_guards()
augroup END
