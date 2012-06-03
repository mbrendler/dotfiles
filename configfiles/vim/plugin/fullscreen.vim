
autocmd VimLeavePre * call Fullscreen#End()

function Fullscreen#Start()
  let g:x_before_fullscreen = getwinposx()
  let g:y_before_fullscreen = getwinposy()
  let g:lines_before_fullscreen = &lines
  let g:columns_before_fullscreen = &columns
  winpos 0 0
  set lines=999
  set columns=999
endfunction

function Fullscreen#End()
  if exists('g:x_before_fullscreen')
    execute "winpos " . g:x_before_fullscreen . " " . g:y_before_fullscreen
    execute "set lines=" . g:lines_before_fullscreen
    execute "set columns=" . g:columns_before_fullscreen
    unlet g:x_before_fullscreen
    unlet g:y_before_fullscreen
    unlet g:lines_before_fullscreen
    unlet g:columns_before_fullscreen
  endif
endfunction

function Fullscreen#Toggle()
  if exists('g:x_before_fullscreen')
    call Fullscreen#End()
  else
    call Fullscreen#Start()
  endif
endfunction
