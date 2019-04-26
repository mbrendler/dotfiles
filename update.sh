#!/usr/bin/env bash

set -euo pipefail

function retry() {
  "$@"
  if test $? -ne 0 ; then
    sleep 1
    "$@"
  fi
  if test $? -ne 0 ; then
    sleep 1
    "$@"
  fi
}

function git-plugin() {
  local src=$1
  local dst=$2
  if test ! -d "$dst" ; then
    mkdir -p "$dst"
    retry git clone "$src" "$dst" > /dev/null 2> /dev/null && \
      echo "installed ($?) $src" || \
      echo "install failed ($?) $1"
  else
    retry git -C "$dst" pull > /dev/null 2> /dev/null && \
      echo "updated ($?) $1" || \
      echo "update failed ($?) $1"
  fi
}

function plugin() {
  local type=$1
  local dst; dst="$PREFIX/plugins/$type/$(cut -d/ -f 2 <(echo "$2"))"
  local src="https://www.github.com/$2"
  git-plugin "$src" "$dst" &
}

readonly PREFIX="$HOME/.usr"

# zsh plugins -----------------------------------------------------------------

plugin zsh zsh-users/zsh-syntax-highlighting
plugin zsh zsh-users/zsh-completions

# tmux plugins ----------------------------------------------------------------

plugin tmux tmux-plugins/tmux-yank

# vim plugins -----------------------------------------------------------------

### file and buffer access
plugin vim scrooloose/nerdtree
plugin vim ctrlpvim/ctrlp.vim
plugin vim christoomey/vim-tmux-navigator

### programming languages
plugin vim w0rp/ale
plugin vim majutsushi/tagbar
plugin vim Rip-Rip/clang_complete
plugin vim lukerandall/haskellmode-vim
plugin vim davidhalter/jedi-vim
plugin vim elixir-lang/vim-elixir
plugin vim slashmili/alchemist.vim
plugin vim tpope/vim-endwise # automatically close code blocks in ruby
plugin vim vim-ruby/vim-ruby
plugin vim tpope/vim-rake
plugin vim tpope/vim-projectionist
plugin vim leafgarland/typescript-vim # typescript syntax
plugin vim Shougo/vimproc.vim
plugin vim Quramy/tsuquyomi # typescript completion
plugin vim 1995parham/vim-zimpl

### editing
plugin vim Raimondi/delimitMate # Automatic closing of quotes, parentheses, ...
plugin vim tpope/vim-surround
plugin vim tpope/vim-repeat
plugin vim tomtom/tcomment_vim
plugin vim terryma/vim-multiple-cursors
plugin vim vim-utils/vim-husk # Historic key bindings in command line
plugin vim henrik/vim-indexed-search # shows the number of search matches

# Wait for background processes -----------------------------------------------

for job in $(jobs -p) ; do
  wait "$job"
done

# Update jedi-vim subrepositories ---------------------------------------------

git -C "$PREFIX"/plugins/vim/jedi-vim/ submodule update --init

pushd "$PREFIX/plugins/vim/vimproc.vim"
make
popd

# Install Python dependencies -------------------------------------------------

if command -v pip3 > /dev/null 2> /dev/null ; then
  pip3 install --user --upgrade \
    pip \
    neovim \
    pynvim \
    pygments \
    pygments-markdown-lexer \
    cmakelint \
    flake8 \
    python-language-server[flake8] \
    python-language-server[rope] \
    python-language-server[yapf] \
    yapf \
    mypy
fi

if command -v hg > /dev/null 2> /dev/null ; then
  readonly LOCAL_PYTHON_PACKAGES="$PREFIX/python_packages"
  mkdir -p "$LOCAL_PYTHON_PACKAGES"
  if test -e "$LOCAL_PYTHON_PACKAGES/crecord" ; then
    hg -R "$LOCAL_PYTHON_PACKAGES/crecord" pull -u
  else
    hg clone https://bitbucket.org/edgimar/crecord "$LOCAL_PYTHON_PACKAGES/crecord"
  fi
fi

# Initialize Vim helptags -----------------------------------------------------

if command -v vim > /dev/null 2> /dev/null ; then
  for plugin_doc_dir in $(/bin/ls -d "$PREFIX"/plugins/vim/*/doc) ; do
    vim "+helptags $plugin_doc_dir" +qall
  done
fi
