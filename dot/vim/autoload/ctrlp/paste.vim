
if(exists('g:loaded_ctrlp_paste')
    \ && g:loaded_ctrlp_find_alternatives)
    \ || v:version < 700 || &cp
  finish
endif
let g:loaded_ctrlp_paste = 1

call add(g:ctrlp_ext_vars, {
  \ 'init': 'ctrlp#paste#init()',
  \ 'accept': 'ctrlp#paste#accept',
  \ 'lname': 'paste',
  \ 'sname': 'paste',
  \ 'type': 'line',
  \ 'sort': 0,
  \ 'specinput': 0,
  \ })

function! ctrlp#paste#init()
  return map(range(0, 9), {i, nr -> string(nr) . ' ' . getreg(nr)})
endfunction

function! ctrlp#paste#accept(mode, str)
  call ctrlp#exit()
  execute ":put " . a:str[0]
endfunction

" Give the extension an ID
let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)

function! ctrlp#paste#start()
  call ctrlp#init(s:id)
endfunction
