{ config, pkgs, ... }:
let
  flake-compat = builtins.fetchTarball {
    url = "https://github.com/edolstra/flake-compat/archive/master.tar.gz";
    sha256 = "0m9grvfsbwmvgwaxvdzv6cmyvjnlww004gfxjvcl806ndqaxzy4j";
  };
  spicetify-nix = (import flake-compat {
    src = builtins.fetchTarball {
      url = "https://github.com/thangisme/spicetify-nix/archive/master.tar.gz";
      sha256 = "0yvkw9i3xk0qn1j01b4mnj912p55zi1v3fdsy77jy3pz8zxfll4h";
    };
  }).defaultNix;
  spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
in
{
  imports = [ spicetify-nix.homeManagerModule ];
  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
    enabledExtensions = with spicePkgs.extensions; [
      fullScreen
      shuffle
      popupLyrics
      keyboardShortcut
    ];
    enabledCustomApps = with spicePkgs.apps; [
      #lyrics-plus      
    ];
  };
}
