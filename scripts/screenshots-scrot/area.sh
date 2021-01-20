#!/bin/bash
scrot -s -e 'mv $f \$HOME/Pictures/Screenies/ && notify-send "Screenshot saved" "Fullscreen screenies at $f"' &
