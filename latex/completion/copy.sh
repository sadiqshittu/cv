#!/usr/bin/env bash

mkdir -p ~/.config/texstudio/completion/user

for f in *.cwl
do
  cp -f $(realpath $f) ~/.config/texstudio/completion/user/$f
done
