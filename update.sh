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
  local branch="$3"
  if [ -n "$branch" ] ; then
    local branch="--branch $branch"
  fi
  if test ! -d "$dst" ; then
    mkdir -p "$dst"
    retry git clone $branch "$src" "$dst" > /dev/null 2> /dev/null && \
      echo "installed ($?) $src ($3)" || \
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
  git-plugin "$src" "$dst" "${3:-}" &
}

readonly PREFIX="$HOME/.usr"

# zsh plugins -----------------------------------------------------------------

plugin zsh zsh-users/zsh-syntax-highlighting
plugin zsh zsh-users/zsh-completions

# tmux plugins ----------------------------------------------------------------

plugin tmux tmux-plugins/tmux-yank

# gdb plugins -----------------------------------------------------------------

plugin gdb hq6/GdbShellPipe

# vim plugins -----------------------------------------------------------------

### file and buffer access
plugin vim scrooloose/nerdtree
plugin vim ctrlpvim/ctrlp.vim
plugin vim christoomey/vim-tmux-navigator

### programming languages
plugin vim neoclide/coc.nvim release
plugin vim majutsushi/tagbar
plugin vim tpope/vim-endwise # automatically close code blocks in ruby

### editing
plugin vim Raimondi/delimitMate # Automatic closing of quotes, parentheses, ...
plugin vim tpope/vim-surround
plugin vim tpope/vim-repeat
plugin vim tomtom/tcomment_vim
plugin vim vim-utils/vim-husk # Historic key bindings in command line
plugin vim henrik/vim-indexed-search # shows the number of search matches
plugin vim SirVer/ultisnips # snippets

# Wait for background processes -----------------------------------------------

for job in $(jobs -p) ; do
  wait "$job"
done

# Install Node modules

if command -v npm > /dev/null 2> /dev/null ; then
  npm install -g neovim
  npm update -g neovim
fi

# Initialize Vim helptags -----------------------------------------------------

if command -v vim > /dev/null 2> /dev/null ; then
  vim +CocUpdate
  vim "+helptags ALL" +qall
fi
