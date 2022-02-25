setlocal expandtab
setlocal shiftwidth=4
setlocal softtabstop=4

function! Python_has_pipfile()
  return strlen(findfile('Pipfile', ';')) != 0
endfunction

function! Python_find_test_name(filename, line)
  let l:test_name = ''

ruby <<EOF
  line_number = Vim.evaluate('a:line').to_i
  re = /^ *def (test_[a-zA-Z0-9_]+)/.freeze
  last = ''
  open(Vim.evaluate('a:filename')).each_with_index do |line, i|
    break if i >= line_number
    match = re.match(line)
    next if match.nil?

    last = match[1]
  end
  Vim.command("let l:test_name = '#{last}'")
EOF

  return l:test_name
endfunction

function! Run_python_file(filename, ...)
  let l:command = 'python3'
  let l:filename = shellescape(a:filename)
  if a:filename =~ 'test_[^/]*.py$'
    let l:command = 'py.test -vv'
    if a:0 > 0
      let l:test_name = shellescape(Python_find_test_name(a:filename, a:1))
      let l:filename = l:filename . '::' . l:test_name
    endif
  endif
  if Python_has_pipfile()
    let l:command = 'pipenv run ' . l:command
  endif
  call Run_run(l:command . ' ' . l:filename, 1)
endfunction

function! Run_python_file_interactive(filename)
  let l:command = 'ipython'
  if Python_has_pipfile()
    let l:command = 'pipenv run ' . l:command
  endif
  call Run_run(l:command . ' -i ' . a:filename, 0)
endfunction

inoremap <silent><expr> <C-x><C-o> coc#refresh()
