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

plugin vim int3/vim-taglist-plus
plugin vim vim-scripts/taglist.vim

### programming languages
plugin vim neomake/neomake
plugin vim Rip-Rip/clang_complete
plugin vim lukerandall/haskellmode-vim
plugin vim davidhalter/jedi-vim
plugin vim elixir-lang/vim-elixir
plugin vim tpope/vim-endwise # automatically close code blocks in ruby
plugin vim tpope/vim-rake
plugin vim tpope/vim-projectionist

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

# Install Python dependencies -------------------------------------------------

if which pip > /dev/null 2> /dev/null ; then
  pip install --user -U pip
  pip install --user -U neovim
  pip install --user -U pygments
  pip install --user -U pygments-markdown-lexer
fi

if which hg > /dev/null 2> /dev/null ; then
readonly LOCAL_PYTHON_PACKAGES="$PREFIX/python_packages"
mkdir -p "$LOCAL_PYTHON_PACKAGES"
  if test -e "$LOCAL_PYTHON_PACKAGES/crecord" ; then
    hg -R "$LOCAL_PYTHON_PACKAGES/crecord" pull -u
  else
    hg clone https://bitbucket.org/edgimar/crecord "$LOCAL_PYTHON_PACKAGES/crecord"
  fi

  if which pip > /dev/null 2> /dev/null ; then
    pip install --user -U mercurial-keyring
  fi
fi

# Initialize Vim helptags -----------------------------------------------------

if which vim > /dev/null 2> /dev/null ; then
  for plugin_doc_dir in $(/bin/ls -d "$PREFIX"/plugins/vim/*/doc) ; do
    vim "+helptags $plugin_doc_dir" +qall
  done
fi
