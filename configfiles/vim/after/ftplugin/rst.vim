
setlocal textwidth=79
 
setlocal expandtab
setlocal shiftwidth=3
setlocal softtabstop=3

" heading convention for Python documents
" (http://sphinx-doc.org/rest.html#sections):
" # with overline, for parts
" * with overline, for chapters
" =, for sections
" -, for subsections
" ^, for subsubsections
" ", for paragraphs

nnoremap <LocalLeader>h1 :normal! yypVr#yykP<cr>
nnoremap <LocalLeader>h2 :normal! yypVr*yykP<cr>
nnoremap <LocalLeader>h3 :normal! yypVr=<cr>
nnoremap <LocalLeader>h4 :normal! yypVr-<cr>
nnoremap <LocalLeader>h5 :normal! yypVr^<cr>
nnoremap <LocalLeader>h6 :normal! yypVr"<cr>

onoremap ih :<c-u>execute "normal! ?.\\+\\n[#*=-^\"]\\{2,}\r:nohlsearch\r0vg_"<cr>
