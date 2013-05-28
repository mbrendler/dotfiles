
nnoremap <Leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <Leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>

function! s:GrepOperator(type)
  let saved_unnamed_register = @@

  if a:type ==# 'v'
    execute "normal! `<v`>y"
  elseif a:type ==# 'char'
    execute "normal `[v`]y"
  else
    " Ignore a:type == 'line', 'block, 'V', ; because it makes no sense to
    " search for patterns with a new line character.
    return
  endif

  silent execute "grep! -R " . shellescape(@@) . " ."
  copen

  let @@ = saved_unnamed_register
  if &clipboard == "unnamed,unnamedplus"
    let @* = saved_unnamed_register
    let @+ = saved_unnamed_register
  endif
endfunction
