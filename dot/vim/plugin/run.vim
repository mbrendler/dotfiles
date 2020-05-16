function! Save_buffer_if_modified()
  if &modified == 1
    write
  endif
endfunction

function! Run_set_global_command(command)
  let g:run_command = a:command
endfunction

function! Run_unset_global_command()
  unlet g:run_command
endfunction

function! Run_set_command(command)
  let b:run_command = a:command
endfunction

function! Run_unset_command()
  unlet b:run_command
endfunction

function! Run_history()
  if exists('g:run_history')
    return g:run_history
  endif
  return []
endfunction

function! Run_add_to_history(command)
  if !exists('g:run_history')
    let g:run_history = []
  endif
  let l:index = index(g:run_history, a:command)
  if l:index > -1
    call remove(g:run_history, a:command)
  endif
  call add(g:run_history, a:command)
endfunction

function! Run_last_command()
  let l:history = Run_history()
  if empty(l:history)
    echom 'run history is empty'
  else
    call Run_run(l:history[len(l:history) - 1], 0)
  endif
endfunction

function! Run_file(filename)
  if exists('b:run_command')
    call Tmux_run_command(b:run_command)
  elseif exists('g:run_command')
    call Tmux_run_command(g:run_command)
  else
    execute 'call Run_' . &filetype . '_file("' . a:filename . '")'
  endif
endfunction

function! Run_file_line(filename, line)
  execute 'call Run_' . &filetype . '_file("' . a:filename . '", ' . a:line . ')'
endfunction

function! Run_interactive_file(filename)
  execute 'call Run_' . &filetype . '_interactive("' . a:filename . '")'
  call Tmux_select_target_pane()
endfunction

function Run_run(command, add_to_hostory)
  if a:add_to_hostory
    call Run_add_to_history(a:command)
  endif
  call Tmux_run_command(a:command)
endfunction
