function! Run_cucumber_file(filename, ...)
  let l:command = 'cucumber'
  let l:filename = shellescape(a:filename)
  if !empty(findfile('Gemfile', ';'))
    let l:command = 'bundle exec ' . l:command
  endif
  if a:0 > 0
    let l:filename = l:filename . ':' . a:1
  endif
  call Run_run(l:command . ' ' . a:filename, 1)
endfunction
