local awful = require("awful")

-- Startup Applications
autorun_enabled = true

autorun_apps = 
{
	-- NVIDIA STUFF
    "prime-offload",
	"optimus-manager --switch integrated",
	-- AUDIO
    "pulseaudio --start",
    "jack_control status || cadence-session-start -s",
	"/usr/local/share/dotfiles/scripts/Audio/jack/jack_input_dual_mono_to_stereo_rewire.sh",
	-- DISPLAY
    "/home/ccxex29/.screenlayout/dual-left-right.sh",
	"/usr/local/share/dotfiles/scripts/screenlocker-i3lock/screenlock.sh",
	-- LANGUAGE
	"fcitx5",
	-- DISK
	-- Automount all media 
    --"udiskie -a",
}

if autorun_enabled then
    for i = 1, #autorun_apps do
        awful.spawn.with_shell(autorun_apps[i])
    end
end

return autostart
