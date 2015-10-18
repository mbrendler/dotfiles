:setlocal nospell

function! Elixir_run(filename)
  call Tmux_run_command('elixir ' . a:filename)
endfunction

function! Elixir_run_interactive(filename)
  call Tmux_run_command('iex ' . a:filename)
endfunction
