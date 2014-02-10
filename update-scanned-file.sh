#!/bin/bash
set -e

(set -x

export PATH=/usr/local/bin:$PATH
sourcefile=`xattr -p com.kamit.sourcefile "$1"`

if [ -f "$sourcefile" ]
then
	# Set source file tags to the tags of this file
	tag -r \* "$sourcefile"

	# Copy tags back to the original file
	tag -gl "$1" | tail +2 | while read tag
	do
		tag -a "$tag" "$sourcefile"
	done

	# Rename the source file to look like this one
	destination=`dirname "$sourcefile"`/../"To File Raw"
	newname=`basename "$1"`

	mv "$sourcefile" "$destination"/"$newname"
fi

) 2>&1 | logger -t update-scanned-file
