highlight NERDTreeFile ctermbg=none

augroup NerdTreeShowCurrentLine
  autocmd!
  autocmd CursorMoved <buffer> echo substitute(getline('.'), '^.*', '', '')
augroup END
