{ config, pkgs, unstable-pkgs, ... }:

{
  imports = [
    ./programs/base.nix
    ./gui/base.nix
  ];

  home.username = "thang";
  home.homeDirectory = "/home/thang";
  xdg.enable = true;
  home.packages = with pkgs; [
    firefox
    jetbrains.clion
    unstable.vscode
    direnv
    anki-bin
    goldendict-ng
    thunderbird
    #libsForQt5.polkit-kde-agent
    btop
    koreader
    stremio
    qbittorrent
    nix-your-shell
    zathura
    mpv
    feh
    cava
    bat
    nyxt
    nixpkgs-fmt
    (vivaldi.override {
      proprietaryCodecs = true;
      enableWidevine = false;
    })
    bitwarden
    apostrophe
    lazygit
    calibre
    cloudflare-warp
    tmux
    onlyoffice-bin
    unstable.obsidian

  ];

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
