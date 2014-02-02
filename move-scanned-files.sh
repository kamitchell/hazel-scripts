#!/bin/bash
here=`dirname "$1"`
tofile="$here/../To File"
sourcefile=`echo "$1" | sed -e '1,$s/ processed by FineReader//'`
mkdir -p "$tofile"
mv "$1" "$tofile"
mv "$sourcefile" "$tofile"
