setlocal nolisp

nnoremap <buffer> <LocalLeader>o :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
nnoremap <buffer> <LocalLeader>s :split %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
nnoremap <buffer> <LocalLeader>ü :call g:ClangGotoDeclaration()<CR>
