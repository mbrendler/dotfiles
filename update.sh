#!/usr/bin/env bash

set -ex

vim +BundleInstall! +qall

pushd ~/.vim/bundle/jedi-vim/
git submodule update --init
popd

pip install -U pip
pip install -U mercurial-keyring
pip install -U hg-git

LOCAL_PYTHON_PACKAGES="$HOME/.python_packages"
mkdir -p $LOCAL_PYTHON_PACKAGES
if test -e "$LOCAL_PYTHON_PACKAGES/crecord" ; then
  hg -R "$LOCAL_PYTHON_PACKAGES/crecord" pull -u
else
  hg clone https://bitbucket.org/edgimar/crecord "$LOCAL_PYTHON_PACKAGES/crecord"
fi
