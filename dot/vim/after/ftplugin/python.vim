setlocal expandtab
setlocal shiftwidth=4
setlocal softtabstop=4

function! Python_run(filename)
  let l:command = 'python3'
  if strlen(findfile('Pipfile', ';')) != 0
    let l:command = 'pipenv run ' . l:command
  endif
  call Tmux_run_command(l:command . ' ' . a:filename)
endfunction

function! Python_run_interactive(filename)
  let l:command = 'python3'
  if strlen(findfile('Pipfile', ';')) != 0
    let l:command = 'pipenv run ' . l:command
  endif
  call Tmux_run_command(l:command . ' -i ' . a:filename)
endfunction
