{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 5;

  networking.hostName = "leaf";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs; [
    xterm
    kdePackages.elisa
    kdePackages.plasma-browser-integration
    kdePackages.discover
  ];

  users.users.thang = {
    shell = pkgs.fish;
  };

  # Install firefox.
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    home-manager
    helix
    git
    wget
    zoxide
    direnv
    nix-your-shell
    spotify
    fastfetch
    thunderbird
    btop
    mpv
    zathura
    fzf
    ffmpeg
    yt-dlp
    stremio
    wineWowPackages.stable
    lutris
    onlyoffice-bin
  ];

  hardware.graphics.enable32Bit = true;

  programs.fish.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.tailscale.enable = true;
  services.gnome.gnome-browser-connector.enable = true;

  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  system.stateVersion = "24.11";
}
