function! Run_elixir_file(filename)
  let l:command = 'elixir'
  if !empty(findfile('mix.exs', ';'))
    let l:command = 'mix run'
  endif
  call Run_run(l:command . ' ' . a:filename, 1)
endfunction

function! Run_elixir_file_interactive(filename)
  if !empty(findfile('mix.exs', ';'))
    call Run_run('iex -S mix', 0)
  else
    call Run_run('iex ' . a:filename, 0)
  endif
endfunction
