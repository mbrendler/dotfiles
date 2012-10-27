
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"""""""""""""""""""""""""""""""""""""""""""
" Add plug-ins installed with vundle here:
"""""""""""""""""""""""""""""""""""""""""""
Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdtree'
Bundle 'xolox/vim-session'
Bundle 'tomtom/tcomment_vim'
Bundle 'scrooloose/syntastic'
Bundle 'sjbach/lusty'

" Automatic closing of quotes, parentheses, ...
Bundle 'Raimondi/delimitMate'

Bundle 'SearchComplete'
Bundle 'int3/vim-taglist-plus'
Bundle 'tpope/vim-surround'

" needs to run: $ bundle install
"               $ rake make
Bundle 'wincent/Command-T'

Bundle 'sjl/gundo.vim'
Bundle 'sjl/clam.vim'
Bundle 'rson/vim-conque'
Bundle 'tpope/vim-fugitive'
Bundle 'Rip-Rip/clang_complete'
Bundle 'Lokaltog/vim-powerline'
Bundle 'kana/vim-scratch'
Bundle 'DirDiff.vim'

Bundle 'derekwyatt/vim-scala'
Bundle 'sellerie/vim-gradle'
Bundle 'sellerie/vim-monty'
