#! /bin/sh

set -ex

readonly DOT_DIR="$HOME/.usr/dotfiles"

mkdir -p "$DOT_DIR"
mkdir -p "$DOT_DIR/../bin"

git clone "ssh://git@codeberg.org/mbrendler/dotfiles.git" "$DOT_DIR"

pushd "$DOT_DIR"
./create-links.sh
./update.sh
popd
