{ config, pkgs, ... } : {
  home.pointerCursor = {
    name = "Catppuccin-Mocha-Lavender-Cursors";
    package = pkgs.catppuccin-cursors.mochaLavender;
    size = 32;
    gtk.enable = true;
    x11.enable = true;
  };
}
