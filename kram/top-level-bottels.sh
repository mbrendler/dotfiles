#! /bin/bash

for i in $(brew list) ; do
  test -z "$(brew uses --installed $i)" && echo $i
done
