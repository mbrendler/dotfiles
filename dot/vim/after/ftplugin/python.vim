setlocal expandtab
setlocal shiftwidth=4
setlocal softtabstop=4

setlocal makeprg=pylint\ -r\ n\ -i\ y\ -f\ parseable\ %
setlocal errorformat=%f:%l:\ %m

function! Python_run(filename)
  let l:command = 'python'
  call Tmux_run_command(l:command . ' ' . a:filename)
endfunction
