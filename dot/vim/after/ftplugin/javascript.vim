nnoremap <buffer> <LocalLeader>o :call JavaScript_toggle_test_and_impl_file()<CR>

inoremap <silent><expr> <C-x><C-o> coc#refresh()
