function! Cucumber_run(filename)
  let l:command = 'cucumber'
  if strlen(findfile('Gemfile', ';')) != 0
    let l:command = 'bundle exec ' . l:command
  endif
  call Tmux_run_command(l:command . ' ' . a:filename)
endfunction
