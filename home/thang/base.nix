{
  config,
  pkgs,
  unstable-pkgs,
  ...
}:

{
  imports = [
    ./programs/base.nix
    ./gui/base.nix
  ];

  home.username = "thang";
  home.homeDirectory = "/home/thang";
  xdg.enable = true;
  home.packages = with pkgs; [
    unstable.firefox
    unstable.vscode
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
    cloudflare-warp
    tmux
    fastfetch
    blueman
    pavucontrol
    onlyoffice-bin
    unstable.obsidian
    unstable.zed-editor
    obs-studio
    unstable.centerpiece
    unstable.lutris
    masterpdfeditor4
    rclone
    xournalpp
    xplr
    jetbrains.idea-ultimate
    jetbrains.datagrip
  ];

  home.sessionVariables = {
    EDITOR = "hx";
  };

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
