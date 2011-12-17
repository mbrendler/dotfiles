
export PATH=/usr/local/bin:$HOME/.gem/ruby/1.8/bin/:/Users/maik/privateroot/usr/bin:/Users/maik/privateroot/gnu/bin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

# Homebrew:
export PYTHONPATH=/usr/local/lib/python:$PYTHONPATH
export NODE_PATH=/usr/local/lib/node_modules/:$NODE_PATH

# VirtualEnvWrapper:
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

# Ruby:
export RUBYOPT=rubygems
export GEM_HOME=$HOME/.gem/ruby/1.8
export GEM_PATH=$HOME/.gem/ruby/1.8:$GEM_PATH


################################################################################


CLICOLOR=1
LSCOLORS=Dxfxcxdxbxegedabagacad
#LSCOLORS=DxGxFxdxCxdxdxhbadExEx
export CLICOLOR LSCOLORS

eval "$(/Users/maik/privateroot/gnu/bin/dircolors -b)"
alias ls="ls --color"
alias grep="grep --color"
alias gvim="macvim"
alias macvim="/Users/maik/Applications/MacVim.app/Contents/MacOS/Vim -g"

#RVM:
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
PS1="\$(~/.rvm/bin/rvm-prompt)$PS1"
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion

