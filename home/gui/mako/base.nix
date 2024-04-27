{ config, pkgs, ... } : {
  home.file.".config/mako" = {
    source = ./.;
    recursive = true;
  };
}
