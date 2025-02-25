{ config, ... }:
{
  programs.zellij = {
    enable = true;
    # enableFishIntegration = true;
    # settings = {
    #   theme = "catppuccin-mocha";
    #   default_layout = "compact";
    #   simplified_ui = true;
    #   pane_frames = false;
    # };
  };
  home.file.".config/zellij/" = {
    source = ./.;
    recursive = true;
  };
}
