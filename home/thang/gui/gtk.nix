{ config, pkgs, ... }:
{
  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-mocha-lavender-standard";
      package = pkgs.catppuccin-gtk.override {
        variant = "mocha";
        accents = [ "lavender" ];
      };
    };
  };
  catppuccin.gtk = {
    icon = {
      enable = true;
      accent = "lavender";
      flavor = "mocha";
    };
  };
}
