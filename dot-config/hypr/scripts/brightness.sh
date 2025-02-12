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
    ags request "show_brightness"
}

# Increase brightness
inc_backlight() {
	brightnessctl s +10%
    notify_user 
}

# Decrease brightness
dec_backlight() {
    if [ "$(get_backlight)" -gt "10" ]; then
	    brightnessctl s 10%-
    fi
    notify_user 
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
