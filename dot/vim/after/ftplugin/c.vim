setlocal expandtab
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal nolisp

nnoremap <LocalLeader>o :e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>
nnoremap <LocalLeader>s :split %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>
