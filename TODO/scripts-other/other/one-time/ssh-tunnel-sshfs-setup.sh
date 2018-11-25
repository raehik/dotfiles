#!/usr/bin/env bash
#
# TODO
#

_BASHPLATE_DIR="$HOME/.local/share/bashplate"
source "$_BASHPLATE_DIR/bashplate.sh"

_usage="\
Usage: $_FILENAME open|close

Mounts read-only so safe enough. pkill is a bit dangerous but w/e, temporary
script.

No options.\
"

# verbose by default
_VERBOSE=1

local_port=9000
remote_dir="media/podcasts"
mnt_dir="archive"

mk_conn() {
    if [[ -e "$mnt_dir" ]]; then
        _log "local dir exists, continuing..."
    else
        _log "creating local dir..."
        mkdir "$mnt_dir" || _err "mkdir failed, error code $?" 4
    fi
    _log "creating SSH tunnel..."
    ssh -fNL $local_port:al-420.local:22 raehik.net
    _log "mounting localhost:$remote_dir READ-ONLY on port $local_port with sshfs..."
    sshfs -o ro -p $local_port localhost:"$remote_dir" "$mnt_dir"
}

close_conn() {
    if [[ ! -e "$mnt_dir" ]]; then
        _err "mount directory $mnt_dir doesn't exist, nothing to close" 3
    fi
    _log "unmounting local dir..."
    fusermount -u "$mnt_dir" \
        || _err "umount not successful" 6

    # find the exact command, and kill it (not ideal but good enough)
    _log "pkill-ing the SSH tunnel we expected to create before..."
    pkill -f "ssh -fNL $local_port:al-420.local:22 raehik.net" \
        || _err "pkill failed! please check the output of ps aux!" 5

    _log "removing local dir..."
    rmdir "$mnt_dir" \
        || _err "rmdir failed, check mount dir ($mnt_dir)"
}

if [[ $# < 1 ]]; then
    _err "argument required"
    _print_usage 1
fi

case "$1" in
    o|open) mk_conn ;;
    c|close) close_conn ;;
    *) _err "unknown command" ; _print_usage 2 ;;
esac
