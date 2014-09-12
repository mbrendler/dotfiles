#!/usr/bin/env bash

set -ex

vim +BundleInstall! +qall

if test -d configfiles/vim/bundle/Command-T/ ; then
    pushd configfiles/vim/bundle/Command-T/
    bundle install
    rake make
    popd
fi

if test $(uname) == 'Darwin' ; then
    mkdir -p $HOME/Library/Fonts/
    cp extras/Monaco-Powerline.otf $HOME/Library/Fonts/
elif test $(uname) == 'Linux' ; then
    mkdir -p $HOME/.fonts/
    cp extras/Monospace-Powerline.ttf $HOME/.fonts/
fi

pushd ~/.vim/bundle/jedi-vim/
git submodule update --init
popd