{ config, pkgs, unstable-pkgs, ... }:
let
  flake-compat = builtins.fetchTarball {
    url = "https://github.com/edolstra/flake-compat/archive/master.tar.gz";
    sha256 = "0m9grvfsbwmvgwaxvdzv6cmyvjnlww004gfxjvcl806ndqaxzy4j";
  };
  spicetify-nix = (import flake-compat {
    src = builtins.fetchTarball {
      url = "https://github.com/Gerg-L/spicetify-nix/archive/master.tar.gz";
      sha256 = "0m2b4mhh21f2whjwyhy7b2g1m5qm1gysl2pn0jzrv5csph8cd8xr";
    };
  }).defaultNix;
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
in
{
  imports = [ spicetify-nix.homeManagerModules.default ];
  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    spicetifyPackage = pkgs.unstable.spicetify-cli;
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
