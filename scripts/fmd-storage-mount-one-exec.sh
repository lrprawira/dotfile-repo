#!/bin/bash

set -eux

sudo mkdir -p /run/media/$USER
sudo chown $USER /run/media/$USER
$HOME/fmd-storage-mount.sh
