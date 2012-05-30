#!/usr/bin/env sh
#
# Set the following lines to .hg/hgrc:
# [hooks]
# update = ./updatehook.sh
#

set -ex

vim +BundleInstall +qall
