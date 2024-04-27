{ config, pkgs, ... } : {
  imports = [
    ./cursor.nix
    ./gtk.nix
    ./qt.nix
    ./prefer-dark.nix
    ./catppuccin.nix
    ./hyprland/base.nix
    ./waybar/base.nix
    ./rofi/base.nix
    ./mako/base.nix
  ];
}
