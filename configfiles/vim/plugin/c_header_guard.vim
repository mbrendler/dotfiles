

function! s:insert_guards()
  let guardname = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  let id = substitute(system("uuidgen"), "[-\n]", "", "g")
  let guardname = guardname . "__" . id
  execute "normal! i#ifndef " . guardname
  execute "normal! o#define " . guardname
  execute "normal! o"
  execute "normal! o"
  execute "normal! o"
  execute "normal! Go#endif /* " . guardname . " */"
  normal! kk
endfunction

autocmd BufNewFile *.{h,hpp} call <SID>insert_guards()
