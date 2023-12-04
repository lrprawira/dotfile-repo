#!/bin/bash

sanitise() {
  str="$1"
  str=${str//\'/\\\'}
  str=${str//\"/\\\"}
  echo "$str"
}

CWD="$1"
DIR_NAME="$(basename "$CWD")"
MOUNT_DIR="$HOME/Documents/Mounts/Gocrypt"
CTLSOCK_DIR="/tmp/gocryptfs"
MOUNT_TARGET="${MOUNT_DIR}/${DIR_NAME}.dec"
CTLSOCK_TARGET="${CTLSOCK_DIR}/${DIR_NAME}.sock"

mkdir -p "$CTLSOCK_DIR"

MSG_DEC="Decrypting ${CWD}"
MSG_INVALID_DIR="$CWD is not a valid GocryptFS directory!"

EVAL_TO_MOUNT="sh -c \"echo \\\"${MSG_DEC}\\\"; \
	gocryptfs -ctlsock \\\"$CTLSOCK_TARGET\\\" \\\"$CWD\\\" \\\"${MOUNT_TARGET}\\\" || \$(rmdir \\\"${MOUNT_TARGET}\\\"; kdialog --error WrongPassword)\""
echo "$EVAL_TO_MOUNT"


notify-send "$CWD"

if [ ! -f "${CWD}/gocryptfs.conf" ] || [ ! -f "${CWD}/gocryptfs.diriv" ]; then
  echo "$MSG_INVALID_DIR"
  kdialog --error "$MSG_INVALID_DIR"
  exit 255
fi

notify-send "Valid!"

mkdir -p "$MOUNT_TARGET"

if [ $(command -v konsole) ]; then
  konsole -e "$EVAL_TO_MOUNT"
else
  echo "No terminal available"
fi
