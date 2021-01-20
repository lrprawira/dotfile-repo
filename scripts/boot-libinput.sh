#!/bin/bash

# If you don't know what simple and advanced touchpad means,
# Check your touchpad settings on your BIOS/UEFI Setup

if [[ $(command -v libinput) ]]; then
	touchpad_fw_driver="libinput" 
else
	touchpad_fw_driver="synaptics"
fi
touchpad_sw_driver="advanced"

# Synaptics
if [[ ${touchpad_fw_driver} == "synaptics" ]]; then
	if [[ ${touchpad_sw_driver} == "simple" ]]; then
		### Simple Touchpad Config ###
		xinput set-prop "ETPS/2 Elantech Touchpad" 304 1000
		xinput set-prop "ETPS/2 Elantech Touchpad" "Synaptics Locked Drags" 1
		xinput set-prop "ETPS/2 Elantech Touchpad" "Synaptics Locked Drags Timeout" 1000
		xinput set-prop "ETPS/2 Elantech Touchpad" "Synaptics Two-Finger Scrolling" 1 1
		xinput set-prop "ETPS/2 Elantech Touchpad" "Synaptics Palm Detection" 1
		xinput set-prop "ETPS/2 Elantech Touchpad" 300 1 1

	elif [[ ${touchpad_sw_driver} == "simple" ]]; then
		### Advanced Touchpad Config ###
		xinput set-prop "ELAN0504:01 04F3:3091 Touchpad" "Synaptics Locked Drags" 1
		xinput set-prop "ELAN0504:01 04F3:3091 Touchpad" "Synaptics Locked Drags Timeout" 1000
		xinput set-prop "ELAN0504:01 04F3:3091 Touchpad" "Synaptics Two-Finger Scrolling" 1 1
		xinput set-prop "ELAN0504:01 04F3:3091 Touchpad" "Synaptics Palm Detection" 1
		xinput set-prop "ELAN0504:01 04F3:3091 Touchpad" "Device Accel Profile" 2
		xinput set-prop "ELAN0504:01 04F3:3091 Touchpad" "Device Accel Velocity Scaling" 6.8
		xinput set-prop "ELAN0504:01 04F3:3091 Touchpad" "Synaptics Tap Durations" 80 180 100
		xinput set-prop "ELAN0504:01 04F3:3091 Touchpad" "Synaptics Finger" 10 15 0
	fi

# Libinput
elif [[ ${touchpad_fw_driver} == "libinput" ]]; then
	[ ${touchpad_sw_driver} ] && echo "Ignoring touchpad_sw_driver"
	xinput set-prop "ELAN0504:01 04F3:3091 Touchpad" "libinput Tapping Enabled" 1
	xinput set-prop "ELAN0504:01 04F3:3091 Touchpad" "libinput Tapping Drag Lock Enabled" 1
	xinput set-prop "ELAN0504:01 04F3:3091 Touchpad" "libinput Accel Speed" 0.28
	xinput set-prop "ELAN0504:01 04F3:3091 Touchpad" "libinput Middle Emulation Enabled" 1
fi

