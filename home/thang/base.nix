{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./programs/base.nix
    ./gui/base.nix
  ];

  nixpkgs.config.allowUnfreePredicate = (_: true);

  home.username = "thang";
  home.homeDirectory = "/home/thang";
  xdg.enable = true;
  home.packages = with pkgs; [
    vscode
    anki-bin
    goldendict-ng
    stremio
    qbittorrent
    nix-your-shell
    bitwarden
    calibre
    blueman
    pavucontrol
    obsidian
    zed-editor
    obs-studio
    masterpdfeditor4
  ];

  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
