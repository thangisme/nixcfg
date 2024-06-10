{ config, pkgs, ... } : {
  home.file.".config/swaync" = {
    source = ./.;
    recursive = true;
  };
}
