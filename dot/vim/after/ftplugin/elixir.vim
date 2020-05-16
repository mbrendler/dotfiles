function! Elixir_run(filename)
  let l:command = 'elixir'
  if strlen(findfile('mix.exs', ';')) != 0
    let l:command = 'mix run'
  endif
  call Tmux_run_command(l:command . ' ' . a:filename)
endfunction

function! Elixir_run_interactive(filename)
  if strlen(findfile('mix.exs', ';')) != 0
    call Tmux_run_command('iex -S mix')
  else
    call Tmux_run_command('iex ' . a:filename)
  endif
endfunction
