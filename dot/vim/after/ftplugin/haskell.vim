function! Haskell_run(filename)
  let l:command = 'runhaskell'
  call Tmux_run_command(l:command . ' ' . a:filename)
endfunction
