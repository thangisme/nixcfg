{ config, ... }:
{
  programs.btop = {
    enable = true;
  };
  catppuccin.btop.enable = true;
}
