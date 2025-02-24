{ config, pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
    font.name = "IosevkaTerm Nerd Font";
    shellIntegration = {
      enableFishIntegration = true;
      mode = "no-cursor";
    };
    extraConfig = ''
      window_padding_width 4 8
      hide_window_decorations true
    '';
  };
}
