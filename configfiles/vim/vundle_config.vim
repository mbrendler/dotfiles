
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
Bundle 'Raimondi/delimitMate'
Bundle 'SearchComplete'
Bundle 'int3/vim-taglist-plus'
Bundle 'tpope/vim-surround'

" needs to run: $ bundle install
"               $ rake make
Bundle 'wincent/Command-T'
