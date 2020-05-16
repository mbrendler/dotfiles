
if(exists('g:loaded_ctrlp_run')
    \ && g:loaded_ctrlp_find_alternatives)
    \ || v:version < 700 || &cp
  finish
endif
let g:loaded_ctrlp_run = 1

call add(g:ctrlp_ext_vars, {
  \ 'init': 'ctrlp#run#init()',
  \ 'accept': 'ctrlp#run#accept',
  \ 'lname': 'run',
  \ 'sname': 'run',
  \ 'type': 'line',
  \ 'sort': 0,
  \ 'specinput': 0,
  \ })

function! ctrlp#run#init()
  return Run_history()
endfunction

function! ctrlp#run#accept(mode, str)
  call ctrlp#exit()
  call Run_run(a:str, 0)
endfunction

" Give the extension an ID
let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)

function! ctrlp#run#start()
  call ctrlp#init(s:id)
endfunction
