{ config, pkgs, ... }: {
  home.packages = with pkgs; [ waybar playerctl brightnessctl ];
  home.file.".config/waybar" = {
    source = ./.;
    recursive = true;
  };
}
