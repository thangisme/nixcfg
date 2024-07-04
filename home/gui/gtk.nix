{ config, pkgs, ... }: {
  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-mocha-lavender-standard+default";
      package = pkgs.catppuccin-gtk.override {
        variant = "mocha";
        accents = [ "lavender" ];
      };
    };
    catppuccin = {
      icon = {
        enable = true;
        accent = "lavender";
        flavor = "mocha";
      };
    };
  };
}
