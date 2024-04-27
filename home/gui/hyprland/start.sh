#!/usr/bin/env bash
# Initializing wallpapaer daemon
swww init &

# Network applet
nm-applet --indicator &

# Bar
waybar &

# Notification
mako & 

# Clipboard
wl-paste --watch cliphist store &
