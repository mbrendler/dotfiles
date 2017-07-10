setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal nolisp

nnoremap <LocalLeader>o :e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>
nnoremap <LocalLeader>s :split %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>
nnoremap <LocalLeader>ü :call g:ClangGotoDeclaration()<CR>
