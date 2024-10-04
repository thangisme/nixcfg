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
    thunderbird
    btop
    stremio
    qbittorrent
    nix-your-shell
    zathura
    mpv
    feh
    cava
    bat
    ungoogled-chromium
    bitwarden
    lazygit
    calibre
    tmux
    fastfetch
    blueman
    pavucontrol
    onlyoffice-bin
    obsidian
    zed-editor
    obs-studio
    lutris
    masterpdfeditor4
    rclone
    xournalpp
    xplr
    jetbrains.idea-ultimate
    jetbrains.datagrip
    zellij
  ];

  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
