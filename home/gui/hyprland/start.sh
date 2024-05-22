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

# Battery monitor
batsignal &

# Screen shader
dbus-update-activation-environment --systemd HYPRLAND_INSTANCE_SIGNATURE
hyprshade auto

# Idle detection and lock screen
hypridle &
