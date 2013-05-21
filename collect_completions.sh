#!/bin/bash


COMPLETION_DEFINITIONS=(
  "brew:/usr/local/Library/Contributions/brew_zsh_completion.zsh"
  "hg:$HOME/privateroot/orr/orr_dir/packages/mercurial/contrib/zsh_completion"
  "pip:$HOME/.zsh/oh-my-zsh/plugins/pip/_pip"
  "vagrant:$HOME/.zsh/oh-my-zsh/plugins/vagrant/_vagrant"
)


ZSH_SITE_FUNCTIONS=$HOME/.zsh/site-functions
mkdir -p $ZSH_SITE_FUNCTIONS


for COMPLETION_DEFINITION in ${COMPLETION_DEFINITIONS[@]} ; do
    NAME="${COMPLETION_DEFINITION%%:*}"
    SOURCE="${COMPLETION_DEFINITION##*:}"
    DESTINATION=$ZSH_SITE_FUNCTIONS/_$NAME

    if test -e $SOURCE ; then
        if test -e $DESTINATION && cmp -s $SOURCE $DESTINATION ; then
             echo skip $NAME
	else
             echo copy $NAME
	     cp $SOURCE $DESTINATION
        fi
    else
        echo $SOURCE does not exist.
    fi
done
