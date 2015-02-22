
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"""""""""""""""""""""""""""""""""""""""""""
" Add plug-ins installed with vundle here:
"""""""""""""""""""""""""""""""""""""""""""
Bundle 'gmarik/vundle'

" file and buffer access
Bundle 'scrooloose/nerdtree'
Bundle 'sjbach/lusty'
Bundle 'kien/ctrlp.vim'

" Bundle 'Lokaltog/vim-powerline'
Bundle 'int3/vim-taglist-plus'
Bundle 'vim-scripts/taglist.vim'

" programming languages
Bundle 'scrooloose/syntastic'
Bundle 'Rip-Rip/clang_complete'
Bundle 'vim-scripts/Cpp11-Syntax-Support'
Bundle 'lukerandall/haskellmode-vim'
Bundle 'derekwyatt/vim-scala'
Bundle 'davidhalter/jedi-vim'
Bundle 'sellerie/vim-gradle'
Bundle 'elixir-lang/vim-elixir.git'
Bundle 'ap/vim-css-color.git'
Bundle 'vim-emblem'
Bundle 'dsawardekar/ember.vim'
"" automatically close code blocks in ruby
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-rake'
Bundle 'tpope/vim-projectionist'

" editing
"" Automatic closing of quotes, parentheses, ...
Bundle 'Raimondi/delimitMate'
Bundle 'tpope/vim-surround'
Bundle 'tomtom/tcomment_vim'

" search plugins
"" shows the number of matches on (/, ?, n, N, *, #)
Bundle 'henrik/vim-indexed-search'
"" Completion in search lines
" Bundle 'SearchComplete'

" Bundle 'sjl/clam.vim'
" Creates a buffer, which is not saved
" Bundle 'kana/vim-scratch'

" if has('mac')
"   Bundle 'rizzatti/funcoo.vim'
"   Bundle 'rizzatti/dash.vim'
" endif

" Bundle 'tpope/vim-fugitive'
