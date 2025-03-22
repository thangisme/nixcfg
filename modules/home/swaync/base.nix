{ config, pkgs, ... }:
{
  home.packages = [ pkgs.swaynotificationcenter ];
  home.file.".config/swaync" = {
    source = ./.;
    recursive = true;
  };
}
