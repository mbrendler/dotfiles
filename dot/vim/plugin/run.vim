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

function! Run_file(filename)
  if exists('b:run_command')
    call Tmux_run_command(b:run_command)
  elseif exists('g:run_command')
    call Tmux_run_command(g:run_command)
  else
    let l:prefix = substitute(&filetype, "^.", "\\U&", "")
    execute 'call ' . l:prefix . '_run("' . a:filename . '")'
  endif
endfunction

function! Run_interactive_file(filename)
  let l:prefix = substitute(&filetype, "^.", "\\U&", "")
  execute 'call ' . l:prefix . '_run_interactive("' . a:filename . '")'
  call Tmux_select_target_pane()
endfunction
