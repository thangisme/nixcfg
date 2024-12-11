{ config, pkgs, ... }:
let
  flake-compat = builtins.fetchTarball {
    url = "https://github.com/edolstra/flake-compat/archive/master.tar.gz";
    sha256 = "19d2z6xsvpxm184m41qrpi1bplilwipgnzv9jy17fgw421785q1m";
  };
  spicetify-nix =
    (import flake-compat {
      src = builtins.fetchTarball {
        url = "https://github.com/Gerg-L/spicetify-nix/archive/3127c5663ec8697c3b2a6d291c916b2147312137.zip";
        sha256 = "07ih7k19nhlayr88rfbg6cpv2d2g2qk41n962v3gakln73frn2rb";
      };
    }).defaultNix;
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
in
{
  imports = [ spicetify-nix.homeManagerModules.default ];
  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    spicetifyPackage = pkgs.spicetify-cli;
    colorScheme = "mocha";
    enabledExtensions = with spicePkgs.extensions; [
      fullScreen
      shuffle
      popupLyrics
      keyboardShortcut
      betterGenres
    ];
    enabledCustomApps = with spicePkgs.apps; [
      lyricsPlus
    ];
  };
}
