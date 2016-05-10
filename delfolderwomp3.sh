#! /bin/bash

find -type d | { while read -r D;
  do
  v=$(find "$D" -iname '*.mp3');
  case "$v" in
  "" )
    echo "$D no mp3"
    rm -r "$D";;
  esac
done }