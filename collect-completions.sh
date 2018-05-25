#! /usr/bin/env zsh

COMPLETION_DEFINITIONS=(
  "ag:$HOME/.usr/plugins/zsh/zsh-completions/src/_ag"
  "brew:/usr/local/Library/Contributions/brew_zsh_completion.zsh"
  "bundler:$HOME/.usr/plugins/zsh/zsh-completions/src/_bundle"
  "cabal:$HOME/.usr/plugins/zsh/zsh-completions/src/_cabal"
  "cmake:$HOME/.usr/plugins/zsh/zsh-completions/src/_cmake"
  "docker-compose:/Applications/Docker.app/Contents/Resources/etc/docker-compose.zsh-completion"
  "docker-machine:/Applications/Docker.app/Contents/Resources/etc/docker-machine.zsh-completion"
  "docker:/Applications/Docker.app/Contents/Resources/etc/docker.zsh-completion"
  "gem:$HOME/.usr/plugins/zsh/zsh-completions/src/_gem"
  "ghc:$HOME/.usr/plugins/zsh/zsh-completions/src/_ghc"
  "go:$HOME/.usr/plugins/zsh/zsh-completions/src/_go"
  "i:$HOME/Documents/src/projects/i/zsh-completion/_i"
  "iwfmlogs:$HOME/work/iwfm-logs/zsh-completion/_iwfmlogs"
  "jq:$HOME/.usr/plugins/zsh/zsh-completions/src/_jq"
  "mix:$HOME/.usr/plugins/zsh/zsh-completions/src/_mix"
  "rails:$HOME/.usr/plugins/zsh/zsh-completions/src/_rails"
  "redis-cli:$HOME/.usr/plugins/zsh/zsh-completions/src/_redis-cli"
  "pgsql_utils:$HOME/.usr/plugins/zsh/zsh-completions/src/_pgsql_utils"
  "tig:/usr/local/etc/bash_completion.d/tig-completion.bash"
  "tmux:/usr/local/etc/bash_completion.d/tmux"
  "virtualbox:$HOME/.usr/plugins/zsh/zsh-completions/src/_virtualbox"
  "winrm:$HOME/Documents/src/projects/winrm-terminal/zsh_completion/_winrm"
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

sed -Ei '' 's/^#compdef i.*$/#compdef i p post drain fin/' dot/zsh/site-functions/_i

# rebuild zcompdumb:
rm -f ~/.zcompdump
compinit () {
        # undefined
        builtin autoload -XUz
}
compinit
