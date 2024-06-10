{ config, pkgs, ... } : {
  imports = [
    ./gtk.nix
    ./qt.nix
    ./prefer-dark.nix
    ./hyprland/base.nix
    ./waybar/base.nix
    ./rofi/base.nix
    ./swaync/base.nix
    ./polkit.nix
  ];
}
