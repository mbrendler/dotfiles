#!/usr/bin/env bash
#
# Set the following lines to .hg/hgrc:
# [hooks]
# update = ./updatehook.sh
#

set -ex

vim +BundleInstall +qall

if test -d configfiles/vim/bundle/Command-T/ ; then
    pushd configfiles/vim/bundle/Command-T/
    bundle install
    rake make
    popd
fi

if test $(uname) == 'Darwin' ; then
    cp extras/Monaco-Powerline.otf $HOME/Library/Fonts/
elif test $(uname) == 'Linux' ; then
    cp extras/Monospace-Powerline.ttf $HOME/.fonts/
fi
