setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2

nnoremap <LocalLeader>o :call TypeScript_toggle_test_and_impl_file()<CR>
nnoremap <LocalLeader>f :call TypeScript_fix()<CR>
