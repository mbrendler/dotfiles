
function! Tmux_select_window(windowNr)
  return system("tmux select-window -t" . a:windowNr)
endfunction

function! Tmux_previous_window()
  return Tmux_select_window(":-1")
endfunction

function! Tmux_next_window()
  return Tmux_select_window(":+1")
endfunction

function! Tmux_send_key(keys)
  return system("tmux send-keys '" . a:keys . "'")
endfunction

function! Tmux_send_text(text)
  call system("tmux set-buffer '" . substitute(a:text, "'", "'\\\\''", 'g') . "'")
  call system("tmux paste-buffer")
endfunction
