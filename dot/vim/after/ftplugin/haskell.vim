setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2

compiler ghc

setlocal nospell

function! Haskell_run(filename)
  let l:command = 'runhaskell'
  call Tmux_run_command(l:command . ' ' . a:filename)
endfunction
