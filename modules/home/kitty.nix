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
      tab_bar_style powerline
      tab_powerline_style slanted
      window_margin_width 1
      single_window_margin_width 0
    '';
  };
}
