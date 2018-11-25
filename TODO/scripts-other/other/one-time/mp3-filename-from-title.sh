#!/usr/bin/env bash
#
# Update a directory of MP3 files to match their filenames to their titles, in a
# shell-friendly manner.
#
# Requires:
#   * ezstring from raehik/scripts (https://github.com/raehik/scripts)
#   * mid3v2 (python module I think)
#   * a good sed
#
# Written to programatically fix filenames from a We're Alive podcast RSS feed.
#

get_mp3_title() {
    mid3v2 "$1" | sed -n 's/^TIT2=*//p'
}

get_friendly_filename() {
    ezstring "$1" | sed \
        -e 's/chapter-/c/' \
        -e '0,/c\([0-9]\)-/s/c\([0-9]\)-/c0\1-/' \
        -e 's/part-\([0-9]\)/p\1/'
}

for orig_file in *.mp3 ; do
    echo "processing ${orig_file}..."
    new_filename="$(get_friendly_filename "$(get_mp3_title "$orig_file")").mp3"
    if [[ "$new_filename" == "$orig_file" ]]; then
        echo "no change in filename, skipping"
        continue
    fi

    # save the original filename in a comment
    mid3v2 --comment="original filename:${orig_file}:eng" "$orig_file"
    if [[ $? != 0 ]]; then
        echo "error: mid3v2 had an error, not moving file"
        exit 1
    fi
    mv "$orig_file" "$new_filename"
done
