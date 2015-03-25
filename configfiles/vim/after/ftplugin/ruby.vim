setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2

function! Ruby_go_to_test()
  let l:base_filename = expand('%:t:r')
  let l:spec_filename = l:base_filename . '_spec.rb'
  let l:test_file = findfile(l:spec_filename, getcwd() . '/**')
  execute 'edit ' . l:test_file
endfunction

function! Ruby_go_to_implementation()
  let l:base_filename = expand('%:t:r')
  if l:base_filename =~ '_spec$'
    let l:impl_filename = l:base_filename[:-6] . '.rb'
    let l:impl_file = findfile(l:impl_filename, getcwd() . '/**')
    execute 'edit ' . l:impl_file
  endif
endfunction

function! Ruby_toggle_test_and_impl_file()
  let l:filename = expand('%:t:r')
  if l:filename =~ 'spec'
    call Ruby_go_to_implementation()
  else
    call Ruby_go_to_test()
  endif
endfunction

function! Ruby_run(filename)
  let l:command = 'ruby'
  if strlen(findfile('Gemfile', ';')) != 0
    let l:command = 'bundle exec ruby'
  endif
  execute '!' . l:command . ' ' . a:filename . ' | cat'
endfunction

nnoremap <LocalLeader>r :w<cr>:call Ruby_run(expand('%'))<cr>
" nnoremap <LocalLeader>r :w<cr>:!ruby %<cr>
nnoremap <LocalLeader>o :call Ruby_toggle_test_and_impl_file()<cr>




" Source: https://gist.github.com/jeff-r/1226832
"
" Folding for Ruby
"
" ,z  -- Show only last search
" ,zz -- Show only "describe ..." and "it ..." lines in specs
" ,zd -- Show only "class ..." and "def ..." lines in Ruby files
" zR  -- Remove all folds
"
" From http://vim.wikia.com/wiki/Folding_with_Regular_Expression
nnoremap <LocalLeader>z :setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2<CR>

" Then variations on that, with different searches ...
"
" Fold spec files, displaying "describe ..." and "it ..." lines
function! FoldSpec()
  let @/='\(describe.*do$\|context.*do$\|it.*do$\)'
  setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2
endfunction
nnoremap <LocalLeader>zz :call FoldSpec()<CR>

" Fold Ruby, showing class and method definitions
function! FoldDefs()
  let @/='\(module\ \|class\ \|has_many\ \|belongs_to\ \|_filter\ \|helper\ \|belongs_to\ \|def\ \|private\|protected\)'
  setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2
endfunction
noremap <LocalLeader>zd :call FoldDefs()<CR>

" Set the text that represents folded lines to a simple dash, showing no
" information.
" This way, when viewing folded specs and classes, there is minimal cruft on
" the screen to distract from the unfolded content.
" set foldtext=MyFoldText()
" function! MyFoldText()
"   return "-"
" endfunction
