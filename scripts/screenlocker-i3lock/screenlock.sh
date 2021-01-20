#!/bin/bash

# Set Timeout to 5minutes and lock in 5 seconds
xset s 300 5

# Lock with script when timeout
xss-lock $(dirname ${BASH_SOURCE[0]})/i3lock.sh
