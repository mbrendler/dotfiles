#! /usr/bin/env zsh

COMPLETION_DEFINITIONS=(
  "ag:/usr/local/share/zsh/site-functions/_the_silver_searcher"
  "brew:/usr/local/share/zsh/site-functions/_brew"
  "brew_cask:/usr/local/share/zsh/site-functions/_brew_cask"
  "bundler:$HOME/.usr/plugins/zsh/zsh-completions/src/_bundle"
  "cabal:$HOME/.usr/plugins/zsh/zsh-completions/src/_cabal"
  "cmake:$HOME/.usr/plugins/zsh/zsh-completions/src/_cmake"
  "docker-compose:/Applications/Docker.app/Contents/Resources/etc/docker-compose.zsh-completion"
  "docker:/Applications/Docker.app/Contents/Resources/etc/docker.zsh-completion"
  "gem:$HOME/.usr/plugins/zsh/zsh-completions/src/_gem"
  "ghc:$HOME/.usr/plugins/zsh/zsh-completions/src/_ghc"
  "git:/usr/local/share/zsh/site-functions/_git"
  "go:$HOME/.usr/plugins/zsh/zsh-completions/src/_go"
  "i:$HOME/Documents/src/projects/i/zsh-completion/_i"
  "iwfmlogs:$HOME/work/iwfm-logs/zsh-completion/_iwfmlogs"
  "jq:$HOME/.usr/plugins/zsh/zsh-completions/src/_jq"
  "mix:$HOME/.usr/plugins/zsh/zsh-completions/src/_mix"
  "rails:$HOME/.usr/plugins/zsh/zsh-completions/src/_rails"
  "redis-cli:$HOME/.usr/plugins/zsh/zsh-completions/src/_redis-cli"
  "pgsql_utils:$HOME/.usr/plugins/zsh/zsh-completions/src/_pgsql_utils"
  "tig:/usr/local/share/zsh/site-functions/_tig"
  "tmux:/usr/local/etc/bash_completion.d/tmux"
  "virtualbox:$HOME/.usr/plugins/zsh/zsh-completions/src/_virtualbox"
  "winrm:$HOME/Documents/src/projects/winrm-terminal/zsh_completion/_winrm"
  "youtube-dl:/usr/local/share/zsh/site-functions/_youtube-dl"
)

ZSH_SITE_FUNCTIONS=$HOME/.zsh/site-functions
mkdir -p "$ZSH_SITE_FUNCTIONS"

cp \
  /usr/local/share/zsh/site-functions/git-completion.bash \
  /usr/local/share/zsh/site-functions/tig-completion.bash \
  "$ZSH_SITE_FUNCTIONS"

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
