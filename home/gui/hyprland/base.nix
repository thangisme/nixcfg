{ config, pkgs, ... } : {
  home.packages = with pkgs; [
    mako
    libnotify
    swww
    rofi-wayland
    networkmanagerapplet
    cliphist
    wl-clipboard
    swayosd
    wlogout
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
