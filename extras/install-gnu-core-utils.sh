#! /bin/bash

set -e

readonly COREUTILS_URL='http://ftp.gnu.org/gnu/coreutils/'

function list-all-core-util-versions() {
  curl "$COREUTILS_URL" 2> /dev/null | \
    sed -nE 's/^.*"(coreutils-.*)\.tar\.xz".*$/\1/p'
}

list-all-core-util-versions

readonly NEWEST_RELEASE=$(list-all-core-util-versions | tail -n 1)

if test -z "$NEWEST_RELEASE"; then
  echo no package found
  exit 1
fi

echo install "$NEWEST_RELEASE"
mkdir -p ~/.usr/src
pushd ~/.usr/src
curl --progress --remote-name "$COREUTILS_URL/$NEWEST_RELEASE.tar.xz"
tar xf "$NEWEST_RELEASE.tar.xz"
pushd "$NEWEST_RELEASE"
./configure --prefix="$HOME/.usr/"
make
make install
popd
popd
