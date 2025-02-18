{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./programs/base.nix
    ./gui/base.nix
    ./scripts/base.nix
  ];

  nixpkgs.config.allowUnfreePredicate = (_: true);

  home.username = "thang";
  home.homeDirectory = "/home/thang";
  xdg.enable = true;
  home.packages = with pkgs; [
    kde-rounded-corners
    vscode
    anki
    goldendict-ng
    stremio
    qbittorrent
    nix-your-shell
    calibre
    blueman
    pavucontrol
    obsidian
    zed-editor
    obs-studio
    masterpdfeditor4
    aider-chat
    prismlauncher
    jetbrains-toolbox
    jetbrains.ruby-mine
    qutebrowser
  ];

  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };

  services.kdeconnect.enable = true;

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
