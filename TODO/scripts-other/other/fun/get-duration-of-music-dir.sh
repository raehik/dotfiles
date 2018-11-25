#!/usr/bin/env bash
#
# Add up duration of OGGs and MP3s in a directory (easily expandable to other
# music files).
#
# Requires sox, probably GNU printf.
#

for f in *.ogg *.mp3 ; do
    ts=$((ts + $(printf '%.0f' $(soxi -D "$f"))))
    soxi -d "$f"
done

echo "---"
echo "${ts}s"
printf '%02dh:%02dm:%02ds\n' $(($ts/3600)) $(($ts%3600/60)) $(($ts%60))
