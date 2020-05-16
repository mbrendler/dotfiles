function! Run_cucumber_file(filename)
  let l:command = 'cucumber'
  if !empty(findfile('Gemfile', ';'))
    let l:command = 'bundle exec ' . l:command
  endif
  call Run_run(l:command . ' ' . a:filename, 1)
endfunction
