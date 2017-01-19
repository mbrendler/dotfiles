#! /usr/bin/env zsh

COMPLETION_DEFINITIONS=(
  "ag:/Users/mbrendler/.usr/plugins/zsh/zsh-completions/src/_ag"
  "bower:$HOME/.usr/plugins/zsh/zsh-completions/src/_bower"
  "brew:/usr/local/Library/Contributions/brew_zsh_completion.zsh"
  "bundler:$HOME/.usr/plugins/zsh/zsh-completions/src/_bundle"
  "cabal:$HOME/.usr/plugins/zsh/zsh-completions/src/_cabal"
  "cmake:$HOME/.usr/plugins/zsh/zsh-completions/src/_cmake"
  "docker-machine:$HOME/.usr/plugins/zsh/zsh-completions/src/_docker-machine"
  "gem:$HOME/.usr/plugins/zsh/zsh-completions/src/_gem"
  "ghc:$HOME/.usr/plugins/zsh/zsh-completions/src/_ghc"
  "go:$HOME/.usr/plugins/zsh/zsh-completions/src/_go"
  "hg:$HOME/usr/local/opt/mercurial/share/zsh/site-functions/_hg"
  "i:$HOME/Documents/src/projects/i/zsh-completion/_i"
  "jq:$HOME/.usr/plugins/zsh/zsh-completions/src/_jq"
  "node:$HOME/.usr/plugins/zsh/zsh-completions/src/_node"
  "npm:/usr/local/etc/bash_completion.d/npm"
  "rails:$HOME/.usr/plugins/zsh/zsh-completions/src/_rails"
  "redis-cli:$HOME/.usr/plugins/zsh/zsh-completions/src/_redis-cli"
  "pgsql_utils:$HOME/.usr/plugins/zsh/zsh-completions/src/_pgsql_utils"
  "pip:$HOME/.usr/plugins/zsh/oh-my-zsh/plugins/pip/_pip"
  "tig:/usr/local/etc/bash_completion.d/tig-completion.bash"
  "tmux:/usr/local/etc/bash_completion.d/tmux"
  "vagrant:$HOME/.usr/plugins/zsh/zsh-completions/src/_vagrant"
  "virtualbox:$HOME/.usr/plugins/zsh/zsh-completions/src/_virtualbox"
  "winrm:$HOME/Documents/src/projects/winrm/zsh_completion/_winrm"
  "watch:$HOME/.usr/plugins/zsh/zsh-completions/src/_watch"
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

sed -Ei '' 's/^#compdef i.*$/#compdef i p post drain/' dot/zsh/site-functions/_i

# rebuild zcompdumb:
rm -f ~/.zcompdump
compinit () {
        # undefined
        builtin autoload -XUz
}
compinit
