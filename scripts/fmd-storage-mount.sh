#!/bin/bash

MOUNTPOINT="/run/media/$USER/FmdStorage"
TRANSFERS=8
MULTI_THREADED_STREAMS=8
MOUNT_ARGS="mount --allow-other --rc"
CACHE_ARGS="--vfs-cache-mode full --dir-cache-time 8760h --cache-dir /tmp/rclone/"

mkdir -p "$MOUNTPOINT"

while (( "$#" )); do
	case $1 in
		"webdav")
			shift
			;;
		"--read-only")
			echo "Mounting as read only"
			MOUNT_ARGS="${MOUNT_ARGS} --read-only"
			shift
			;;
	esac
done
#if [ "$MODE" = "webdav" ]; then
#  MOUNT_ARGS="serve webdav"
#fi
COMMAND="rclone --b2-download-url https://cdn.femmund.com ${MOUNT_ARGS} fmd-storage:fmd-storage/ \"${MOUNTPOINT}\" ${CACHE_ARGS} --transfers ${TRANSFERS} --multi-thread-streams ${MULTI_THREADED_STREAMS}"

mkdir -p "$MOUNTPOINT"
eval "$COMMAND"
fusermount -uz "${MOUNTPOINT}"
