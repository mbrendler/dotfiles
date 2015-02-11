#!/bin/bash


COMPLETION_DEFINITIONS=(
  "bower:$HOME/.zsh/oh-my-zsh/plugins/bower/_bower"
  "brew:/usr/local/Library/Contributions/brew_zsh_completion.zsh"
  "bundler:$HOME/.zsh/oh-my-zsh/plugins/bundler/_bundler"
  "gem:$HOME/.zsh/oh-my-zsh/plugins/gem/_gem"
  "hg:/usr/local/opt/mercurial/share/zsh/site-functions/_hg"
  "npm:/usr/local/etc/bash_completion.d/npm"
  "pip:$HOME/.zsh/oh-my-zsh/plugins/pip/_pip"
  "powder:$HOME/.zsh/oh-my-zsh/plugins/powder/_powder"
  "rvm:$HOME/.rvm/scripts/zsh/Completion/_rvm"
  "tig:/usr/local/etc/bash_completion.d/tig-completion.bash"
  "tmux:/usr/local/etc/bash_completion.d/tmux"
  "vagrant:$HOME/.zsh/oh-my-zsh/plugins/vagrant/_vagrant"
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
compinit
