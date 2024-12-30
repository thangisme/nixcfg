{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/wireguard.nix
  ];

  boot.loader.systemd-boot.windows = {
    "11".efiDeviceHandle = "HD0b";
  };

  networking.hostName = "matrix";

  # Desktop Environment.
  services.displayManager = {
    sddm = {
      enable = true;
      wayland = {
        enable = true;
        compositor = "kwin";
      };
    };
  };

  # security.pam.services.sddm.enableGnomeKeyring = true;
  # services.displayManager.defaultSession = "hyprland";

  services.desktopManager.plasma6 = {
    enable = true;
    # enableQt5Integration = false;
  };

  # XDG Portal
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  xdg.autostart.enable = lib.mkForce false;

  # Polkit
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  services.logind = {
    lidSwitch = "suspend-then-hibernate";
    powerKey = "ignore";
    hibernateKey = "ignore";
  };
  systemd.sleep.extraConfig = "HibernateDelaySec=2h";

  # Default shell
  users.users.thang = {
    shell = pkgs.fish;
  };

  system.stateVersion = "23.11";

  environment.localBinInPath = true;

  environment.systemPackages = with pkgs; [
    zoxide
    ungoogled-chromium
    xplr
    rclone
    fastfetch
    thunderbird
    btop
    mpv
    zathura
    imv
    cava
    bat
    fzf
    fd
    pistol
    lazygit
    onlyoffice-bin
    ffmpeg
    yt-dlp
    steam-run
    xwayland-satellite
    kdePackages.kdeconnect-kde
    kdePackages.kmail-account-wizard
    kdePackages.kmail
    kdePackages.merkuro
    kdePackages.koi
  ];

  # Fish
  programs.fish.enable = true;

  # Hyprland
  programs.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
  };

  programs.niri.enable = true;

  programs.xwayland.enable = lib.mkForce true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  programs.file-roller.enable = true;
  # programs.steam.enable = true;
  programs.adb.enable = true;
  services.tailscale.enable = true;
  services.flatpak.enable = true;
  # services.cloudflare-warp.enable = true;

  programs.fuse.userAllowOther = true;
  systemd.services.onr2-mount = {
    enable = false;
    description = "Mount Rclone Remote";
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.rclone}/bin/rclone mount onr2:onthithpt /home/thang/onr2 --config /home/thang/.config/rclone/rclone.conf --allow-other --dir-cache-time 1h --vfs-cache-mode full";
      ExecStop = "${pkgs.coreutils}/bin/fusermount -u /home/thang/onr2";
      Restart = "on-failure";
    };
    wantedBy = [ "multi-user.target" ];
  };

  networking = {
    firewall = rec {
      enable = true;
      allowedTCPPorts = [
        8080
        23170
      ];
      allowedUDPPorts = allowedTCPPorts;
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPortRanges = allowedTCPPortRanges;
    };
  };

  # services.mysql = {
  #   enable = true;
  #   package = pkgs.mariadb;
  # };

  # virtualisation.virtualbox.host.enable = true;
  # users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];
  # nixpkgs.config.allowUnfree = true;
  # virtualisation.virtualbox.host.enableExtensionPack = true;
  # virtualisation.virtualbox.guest.enable = true;
  # virtualisation.virtualbox.guest.dragAndDrop = true;

  services.touchegg.enable = true;
}
