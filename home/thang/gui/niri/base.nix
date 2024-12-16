{ config, pkgs, ... }:
{
  home.file.".config/niri" = {
    source = ./.;
    recursive = true;
  };
}
