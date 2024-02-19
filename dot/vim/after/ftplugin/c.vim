setlocal nolisp

nnoremap <buffer> <LocalLeader>o :e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>
nnoremap <buffer> <LocalLeader>s :split %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>
nnoremap <buffer> <LocalLeader>ü :call g:ClangGotoDeclaration()<CR>

inoremap <silent><expr> <C-x><C-o> coc#refresh()
