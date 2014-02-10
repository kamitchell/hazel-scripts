#!/bin/bash
set -e

(set -x

export PATH=/usr/local/bin:$PATH
here=`dirname "$1"`
tofile="$here/../To File"
sourcefile=`echo "$1" | sed -e '1,$s/ processed by FineReader//'`

# Point to the original file from the processed one
xattr -w com.kamit.sourcefile "$sourcefile" "$1"

# Get tags from the original file
tag -gl "$sourcefile" | tail +2 | while read tag
do
	tag -a "$tag" "$1"
done

# Get the creation date from the original file
# Requires Xcode command line tools
date=$(GetFileInfo -d "$sourcefile")
SetFile -d "$date" "$1") 2>&1 | logger -t update-ocr-file
