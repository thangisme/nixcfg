{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    swaynotificationcenter
    libnotify
    swww
    rofi-wayland
    networkmanagerapplet
    cliphist
    wl-clipboard
    swayosd
    wlogout
    batsignal
    hyprshot
    hypridle
    hyprlock
    hyprshade
    hyprpolkitagent
  ];

  home.file.".config/hypr" = {
    source = ./.;
    recursive = true;
  };

  home.file.".config/hypr/start.sh" = {
    source = ./start.sh;
    executable = true;
  };
}
