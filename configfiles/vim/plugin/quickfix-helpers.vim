
nnoremap <leader>qq :call <SID>QuickfixToggle()<cr>
nnoremap <Leader>qn :cnext<cr>
nnoremap <Leader>qp :cprevious<cr>
nnoremap <Leader>qc :cclose<cr>

let g:quickfix_is_open = 0

function! s:QuickfixToggle()
  if g:quickfix_is_open
    cclose
    let g:quickfix_is_open = 0
    execute g:quickfix_return_to_window . "wincmd w"
  else
    let g:quickfix_return_to_window = winnr()
    copen
    let g:quickfix_is_open = 1
  endif
endfunction
