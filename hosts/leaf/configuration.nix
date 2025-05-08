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
  boot.loader.systemd-boot.edk2-uefi-shell.enable = true;
  boot.loader.systemd-boot.windows."11".efiDeviceHandle = "HD0b";

  boot = {
    plymouth = {
      enable = true;
      theme = "hexagon_dots";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "hexagon_dots" ];
        })
      ];
    };

    # Enable "Silent boot"
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
    loader.timeout = 0;
  };

  networking.hostName = "leaf";

  time.hardwareClockInLocalTime = true;

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
    extraGroups = [ "adbusers" ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    home-manager
    helix
    git
    wget
    zoxide
    nix-your-shell
    spotify
    fastfetch
    thunderbird
    btop
    mpv
    zathura
    fzf
    fd
    ffmpeg
    yt-dlp
    stremio
    wineWowPackages.stable
    lutris
    onlyoffice-bin
  ];

  hardware.graphics.enable32Bit = true;

  programs.fish.enable = true;

  programs.direnv = {
    enable = true;
    silent = true;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.niri.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.tailscale.enable = true;

  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  services.syncthing.enable = true;

  programs.adb.enable = true;

  system.stateVersion = "24.11";
}
