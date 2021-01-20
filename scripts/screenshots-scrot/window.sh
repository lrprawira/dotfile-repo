#!/bin/bash
scrot -ub -e ' mv $f \$HOME/Pictures/Screenies/ && notify-send "Screenshot saved" "Window screenies at $f"
'
