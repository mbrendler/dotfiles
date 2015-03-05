#!/usr/bin/env bash

set -ex

vim +BundleInstall! +qall

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

pip install -U mercurial-keyring
pip install -U hg-git
