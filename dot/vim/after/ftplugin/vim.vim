setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2

setlocal foldmethod=marker

nnoremap <LocalLeader>S ^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>
vnoremap <LocalLeader>S y:execute @@<cr>:echo 'Sourced selection.'<cr>
