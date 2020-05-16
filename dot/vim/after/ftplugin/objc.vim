setlocal nolisp

nnoremap <buffer> <LocalLeader>o :e %:p:s,.h$,.X123X,:s,.m$,.h,:s,.X123X$,.m,<CR>
nnoremap <buffer> <LocalLeader>s :split %:p:s,.h$,.X123X,:s,.m$,.h,:s,.X123X$,.m,<CR>
nnoremap <buffer> <LocalLeader>ü :call g:ClangGotoDeclaration()<CR>
