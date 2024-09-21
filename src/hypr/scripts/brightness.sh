#!/usr/bin/env bash

iDIR="$HOME/.config/mako/icons"

# Get brightness
get_backlight() {
    info=$(echo $(brightnessctl -m) | tr "," " ")
    info=($info)
	echo "${info[3]::-1}"
}

# Get icons
get_icon() {
	echo "$iDIR/brightness.svg"
}

# Notify
notify_user() {
    notify-send -h string:x-canonical-private-synchronous:sys-notify -h int:value:$(get_backlight) -u low -i $(get_icon) "Brightness"
}

# Increase brightness
inc_backlight() {
	brightnessctl s +10%
}

# Decrease brightness
dec_backlight() {
	brightnessctl s 10%-
}

# Execute accordingly
if [[ "$1" == "--get" ]]; then
	get_backlight
elif [[ "$1" == "--inc" ]]; then
	inc_backlight
elif [[ "$1" == "--dec" ]]; then
	dec_backlight
else
	get_backlight
fi
