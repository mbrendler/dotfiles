function! Run_haskell(filename)
  let l:command = 'runhaskell'
  call Run_run(l:command . ' ' . a:filename, 1)
endfunction
