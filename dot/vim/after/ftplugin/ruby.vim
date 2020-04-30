setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal regexpengine=1 " improves performance with highlighting ruby files

function! Ruby_has_gemfile()
  return strlen(findfile('Gemfile', ';')) != 0
endfunction

function! Ruby_run(filename)
  let l:command = 'ruby'
  if a:filename =~ '_spec.rb$'
    let l:command = 'rspec'
  endif
  if Ruby_has_gemfile()
    let l:command = 'bundle exec ' . l:command
  endif
  call Tmux_run_command(l:command . ' ' . a:filename)
endfunction

function! Ruby_run_interactive(filename)
  let l:command = 'pry'
  " if strlen(findfile('Gemfile', ';')) != 0
  "   let l:command = 'bundle exec ' . l:command
  " endif
  call Tmux_run_command(l:command . " --require " . getcwd() . '/' . a:filename)
endfunction

nnoremap <LocalLeader>o :call Ruby_toggle_test_and_impl_file()<cr>
