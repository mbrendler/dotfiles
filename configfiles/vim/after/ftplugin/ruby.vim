setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2

function! Ruby_go_to_test()
  let l:base_filename = expand('%:t:r')
  let l:spec_filename = l:base_filename . '_spec.rb'
  let l:test_file = findfile(l:spec_filename, getcwd() . '/**')
  execute 'edit ' . l:test_file
endfunction

function! Ruby_go_to_implementation()
  let l:base_filename = expand('%:t:r')
  if l:base_filename =~ '_spec$'
    let l:impl_filename = l:base_filename[:-6] . '.rb'
    let l:impl_file = findfile(l:impl_filename, getcwd() . '/**')
    execute 'edit ' . l:impl_file
  endif
endfunction

function! Ruby_toggle_test_and_impl_file()
  let l:filename = expand('%:t:r')
  if l:filename =~ 'spec'
    call Ruby_go_to_implementation()
  else
    call Ruby_go_to_test()
  endif
endfunction

function! Ruby_run(filename)
  let l:command = 'ruby'
  if strlen(findfile('Gemfile', ';')) != 0
    let l:command = 'bundle exec ruby'
  endif
  call Tmux_run_command(l:command . ' ' . a:filename)
endfunction

" TODO
" nnoremap <LocalLeader>rt :call Save_buffer_if_modified()<cr>:call Ruby_run(Ruby_find_test())<cr>
" nnoremap <LocalLeader>rs :call Save_buffer_if_modified()<cr>:call Ruby_run_spec(Ruby_find_spec())<cr>
nnoremap <LocalLeader>o :call Ruby_toggle_test_and_impl_file()<cr>
