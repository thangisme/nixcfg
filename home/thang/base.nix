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
    unstable.lutris
    masterpdfeditor4
    rclone
    xournalpp
    xplr
    jetbrains.idea-ultimate
    jetbrains.datagrip
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # Web browser defaults
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";

      # PDF and epub viewer default
      "application/pdf" = "zathura.desktop";
      "application/epub+zip" = "zathura.desktop";

      # Image viewer default
      "image/png" = "feh.desktop";
      "image/jpeg" = "feh.desktop";
      "image/gif" = "feh.desktop";

      # Video player
      "video/mp4" = "mpv.desktop";

      # Text and code files default
      "text/plain" = "Helix.desktop";
      "text/x-c++src" = "Helix.desktop";
      "text/x-python" = "Helix.desktop";
      "text/x-shellscript" = "Helix.desktop";
      "text/x-java" = "Helix.desktop";
      "text/x-c" = "Helix.desktop";
    };
  };

  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
