#!/usr/bin/env bash

ags run --gtk4
brightnessctl -e

wl-paste --type text --watch cliphist store
wl-paste --type image --watch cliphist store
