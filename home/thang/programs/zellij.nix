{ config, ... }:
{
  programs.zellij = {
    enable = true;
    # enableFishIntegration = true;
    settings = {
      theme = "catppuccin-mocha";
      default_layout = "compact";
      layout = ''
        pane borderless=true
      '';
    };
  };
}
