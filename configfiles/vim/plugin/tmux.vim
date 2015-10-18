
function! Tmux_send_key(keys)
  return system("tmux send-keys '" . a:keys . "'")
endfunction

function! Tmux_send_text(text)
  call system("tmux set-buffer '" . substitute(a:text, "'", "'\\\\''", 'g') . "'")
  call system("tmux paste-buffer -t " . Tmux_get_target_pane())
endfunction

function! Tmux_window_is_zoomed()
  return (system("tmux list-panes -F '#{window_zoomed_flag}' | uniq")) + 0
endfunction

function! Tmux_is_current_pane(pane)
  let l:grep_call = "tmux list-panes -F '#{pane_index}:#{pane_active}' | grep '^" . a:pane . ":1$'"
  let l:grep_result = system(l:grep_call)
  if "" == l:grep_result
    return 0
  else
    return 1
  end
endfunction

function! Tmux_run_command(command)
  if (exists("$TMUX") == 1) && ($TMUX != "") && (Tmux_is_current_pane(Tmux_get_target_pane()) == 0)
    call Tmux_send_text(a:command . "\n")
    if Tmux_window_is_zoomed() == 1
      call system("tmux resize-pane -Z")
    endif
  else
    if has("gui_running")
      execute '!' . a:command . ' | cat'
    else
      execute '!' . a:command
    end
  end
endfunction

function! Tmux_ask_for_target_pane()
  let l:panes = system("tmux list-panes -F '#{pane_index}: #{?pane_active,*, } #{pane_current_command} #{pane_left},#{pane_top},#{pane_width},#{pane_height}'")
  if len(split(l:panes, "\n")) <= 1
    call Tmux_set_target_pane('1')
    return
  endif
  echo l:panes
  if exists('g:tmux_target_pane') == 0 || g:tmux_target_pane == ''
    let g:tmux_target_pane = ''
  end
  call system("tmux display-panes")
  call Tmux_set_target_pane(input('select target pane: ', g:tmux_target_pane))
endfunction

function! Tmux_set_target_pane(pane)
  let g:tmux_target_pane = a:pane
endfunction

function! Tmux_get_target_pane()
  if exists('g:tmux_target_pane') == 0 || g:tmux_target_pane == ''
    call Tmux_ask_for_target_pane()
  end
  return g:tmux_target_pane
endfunction

" Commands -------------------------------------------------------------------

command! -nargs=+ -complete=shellcmd T :call Tmux_run_command("<args>")
