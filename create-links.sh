#! /usr/bin/env bash

set -euo pipefail

pushd "$(dirname "$0")" > /dev/null
readonly HERE="$(pwd)"
popd > /dev/null

readonly SOURCE_DIR="$HERE/dot"
readonly OS_SPECIFIC_SOURCE_DIR="$SOURCE_DIR/_$(uname | tr '[:upper:]' '[:lower:]')"
readonly BACKUP_DIR="$HOME/configsbackup/$(date --iso-8601)"

function is-dotfile() {
  basename "$1" | grep -v '^[._]' > /dev/null 2>&1
}

function backup() {
  echo "backup $1 to $BACKUP_DIR"
  mkdir -p "$BACKUP_DIR"
  mv "$1" "$BACKUP_DIR"
}

for src_file in "$SOURCE_DIR"/* "$OS_SPECIFIC_SOURCE_DIR"/* ; do
  is-dotfile "$src_file" || continue
  dst_filename=".$(basename "$src_file")"
  dst_file="$HOME/$dst_filename"
  if [ "$(readlink "$dst_file")" != "$src_file" ] ; then
    test -e "$dst_file" && backup "$dst_file"
    echo "create link $dst_filename"
    ln -sf "$src_file" "$dst_file"
  fi
done

ln -fs "$SOURCE_DIR/vimrc" "$SOURCE_DIR/vim/init.vim"
mkdir -p "$HOME/.config"
ln -fs "$SOURCE_DIR/vim" "$HOME/.config/nvim"
