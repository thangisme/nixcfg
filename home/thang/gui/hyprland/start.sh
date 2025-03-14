#!/usr/bin/env bash
# Initializing wallpapaer daemon
swww init &

# Network applet
nm-applet --indicator &

# Bar
waybar &

# Notification
# swaync -c /home/thang/.config/swaync/config.json &

# Clipboard
wl-paste --watch cliphist store &

# Battery monitor
batsignal &

# SwayOSD
swayosd-server &

# Screen shader
dbus-update-activation-environment --systemd HYPRLAND_INSTANCE_SIGNATURE
hyprshade auto

# Idle detection and lock screen
hypridle &

# Start Hyprpolkit
systemctl --user start hyprpolkitagent
