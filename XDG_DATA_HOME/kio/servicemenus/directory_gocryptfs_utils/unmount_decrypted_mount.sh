#!/bin/bash

target="$1"

unmount() {
    fusermount -u "$target"
    rmdir "$target"
}

unmount

if [ $? = 0 ]; then
    exit 0
fi

for i in $(seq 1 10); then
    sleep 1
    unmount
fi
