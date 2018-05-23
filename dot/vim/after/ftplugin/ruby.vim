setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2

function! Ruby_run(filename)
  let l:command = 'ruby'
  if strlen(findfile('Gemfile', ';')) != 0
    let l:command = 'bundle exec ruby'
  endif
  call Tmux_run_command(l:command . ' ' . a:filename)
endfunction

nnoremap <LocalLeader>o :call Ruby_toggle_test_and_impl_file()<cr>
