setlocal expandtab
setlocal shiftwidth=4
setlocal softtabstop=4

function! Run_python_file(filename)
  let l:command = 'python3'
  if !empty(findfile('Pipfile', ';'))
    let l:command = 'pipenv run ' . l:command
  endif
  call Run_run(l:command . ' ' . a:filename, 1)
endfunction

function! Run_python_file_interactve(filename)
  let l:command = 'python3'
  if !empty(findfile('Pipfile', ';'))
    let l:command = 'pipenv run ' . l:command
  endif
  call Run_run(l:command . ' -i ' . a:filename, 0)
endfunction

inoremap <silent><expr> <C-x><C-o> coc#refresh()
