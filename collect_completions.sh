#!/bin/zsh


COMPLETION_DEFINITIONS=(
  "bower:$HOME/.zsh/zsh-completions/src/_bower"
  "brew:/usr/local/Library/Contributions/brew_zsh_completion.zsh"
  "bundler:$HOME/.zsh/zsh-completions/src/_bundle"
  "cabal:$HOME/.zsh/zsh-completions/src/_cabal"
  "cmake:$HOME/.zsh/zsh-completions/src/_cmake"
  "gem:$HOME/.zsh/zsh-completions/src/_gem"
  "ghc:$HOME/.zsh/zsh-completions/src/_ghc"
  "hg:/usr/local/opt/mercurial/share/zsh/site-functions/_hg"
  "i:$HOME/Documents/src/i/zsh-completion/_i"
  "jq:$HOME/.zsh/zsh-completions/src/_jq"
  "node:$HOME/.zsh/zsh-completions/src/_node"
  "npm:/usr/local/etc/bash_completion.d/npm"
  "pip:$HOME/.zsh/oh-my-zsh/plugins/pip/_pip"
  "powder:$HOME/.zsh/oh-my-zsh/plugins/powder/_powder"
  "rvm:$HOME/.rvm/scripts/zsh/Completion/_rvm"
  "tig:/usr/local/etc/bash_completion.d/tig-completion.bash"
  "tmux:/usr/local/etc/bash_completion.d/tmux"
  "vagrant:$HOME/.zsh/zsh-completions/src/_vagrant"
  "watch:$HOME/.zsh/zsh-completions/src/_watch"
)


ZSH_SITE_FUNCTIONS=$HOME/.zsh/site-functions
mkdir -p "$ZSH_SITE_FUNCTIONS"


for COMPLETION_DEFINITION in "${COMPLETION_DEFINITIONS[@]}" ; do
  NAME="${COMPLETION_DEFINITION%%:*}"
  SOURCE="${COMPLETION_DEFINITION##*:}"
  if [[ $SOURCE == *bash* ]] ; then
    DESTINATION=$ZSH_SITE_FUNCTIONS/$NAME
  else
    DESTINATION=$ZSH_SITE_FUNCTIONS/_$NAME
  fi

  if test -e $SOURCE ; then
    if test -e "$DESTINATION" && cmp -s "$SOURCE" "$DESTINATION" ; then
      echo skip $NAME
    else
      echo copy $NAME
      cp "$SOURCE" "$DESTINATION"
    fi
  else
    echo $SOURCE does not exist.
  fi
done

# rebuild zcompdumb:
rm -f ~/.zcompdump
compinit () {
        # undefined
        builtin autoload -XUz
}
compinit
