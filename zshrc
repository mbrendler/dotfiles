
PROMPT="%n@%m:%~%{%F{blue}%}$%{%f%} "

export PATH=$HOME/privateroot/usr/bin:$HOME/privateroot/gnu/bin:$PATH

# Homebrew:
if [ -f /usr/local/bin/brew ] ; then
    export PYTHONPATH=/usr/local/lib/python:$PYTHONPATH
    export NODE_PATH=/usr/local/lib/node_modules/:$NODE_PATH
    export PATH=/usr/local/bin:$PATH
fi

# VirtualEnvWrapper:
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
export PATH=$HOME/.virtualenvs/main/bin:$PATH

export PYTHONSTARTUP=/Users/maik/.pystartup

# Ruby:
export RUBYOPT=rubygems
export GEM_HOME=$HOME/.gem/ruby/1.8
export GEM_PATH=$HOME/.gem/ruby/1.8:$GEM_PATH
export PATH=$HOME/.gem/ruby/1.8/bin/:$PATH


################################################################################


eval "$(/Users/maik/privateroot/gnu/bin/dircolors -b)"
alias .=source
alias ls="ls --color"
alias grep="grep --color"
alias gvim="macvim"
alias macvim="/Users/maik/Applications/MacVim.app/Contents/MacOS/Vim -g"


CLICOLOR=1
LSCOLORS=Dxfxcxdxbxegedabagacad
CLICOLOR=LSCOLORS


################################################################################


# Lines configured by zsh-newuser-install
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/maik/.zshrc'
#eval `gdircolors`
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
setopt BASH_AUTO_LIST
setopt NO_AUTO_MENU
setopt NO_ALWAYS_LAST_PROMPT

autoload -Uz compinit
compinit
# End of lines added by compinstall

