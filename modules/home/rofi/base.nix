{ pkgs, ... }:
{
  home.packages = [ pkgs.rofi-wayland ];
  home.file.".config/rofi" = {
    source = ./.;
    recursive = true;
  };
}
