setlocal expandtab
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal nolisp

nnoremap <LocalLeader>o :e %:p:s,.h$,.X123X,:s,.m$,.h,:s,.X123X$,.m,<CR>
nnoremap <LocalLeader>s :split %:p:s,.h$,.X123X,:s,.m$,.h,:s,.X123X$,.m,<CR>
nnoremap <LocalLeader>ü :call g:ClangGotoDeclaration()<CR>
