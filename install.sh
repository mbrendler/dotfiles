#! /bin/sh

set -ex

readonly DOT_DIR="$HOME/.usr/dotfiles"

mkdir -p "$DOT_DIR"
mkdir -p "$DOT_DIR/../bin"

git clone "https://github.com/mbrendler/dotfiles" "$DOT_DIR"

pushd "$DOT_DIR"
create-links.sh
update.sh
popd
