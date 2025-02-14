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

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 5;
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
    extraGroups = [
      "adbusers"
    ];
  };

  system.stateVersion = "23.11";

  hardware.graphics.extraPackages = with pkgs; [
    amdvlk
  ];
  hardware.graphics.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];

  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];
  environment.localBinInPath = true;

  environment.systemPackages = with pkgs; [
    lact
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
    kdePackages.koi
    devenv
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
  # services.flatpak.enable = true;
  # services.cloudflare-warp.enable = true;

  programs.fuse.userAllowOther = true;
  # systemd.services.onr2-mount = {
  #   enable = false;
  #   description = "Mount Rclone Remote";
  #   wants = [ "network-online.target" ];
  #   after = [ "network-online.target" ];
  #   serviceConfig = {
  #     ExecStart = "${pkgs.rclone}/bin/rclone mount onr2:onthithpt /home/thang/onr2 --config /home/thang/.config/rclone/rclone.conf --allow-other --dir-cache-time 1h --vfs-cache-mode full";
  #     ExecStop = "${pkgs.coreutils}/bin/fusermount -u /home/thang/onr2";
  #     Restart = "on-failure";
  #   };
  #   wantedBy = [ "multi-user.target" ];
  # };

  networking = {
    firewall = rec {
      enable = true;
      allowedTCPPorts = [
        8080
        23170
      ];
      allowedUDPPorts = allowedTCPPorts;
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
  # services.mediawiki = {
  #   enable = true;
  #   # Prior to NixOS 24.05, there is a admin name bug that prevents using spaces in the mediawiki name https://github.com/NixOS/nixpkgs/issues/298902
  #   name = "OnThiTHPT";
  #   webserver = "nginx";
  #   nginx.hostName = "localhost";
  #   # httpd.virtualHost = {
  #   #   hostName = "localhost";
  #   #   adminAddr = "admin@example.com";
  #   # };
  #   passwordFile = pkgs.writeText "password" "123456.123456";
  #   extraConfig = ''
  #           # Disable anonymous editing
  #           $wgGroupPermissions['*']['edit'] = false;
  #           # Prevent new user registrations except by sysops
  #           $wgGroupPermissions['*']['createaccount'] = false;

  #           $wgLanguageCode = 'vi';
  #           $wgLocaltimezone = "Asia/Ho_Chi_Minh";
  #           $wgDefaultMobileSkin = 'citizen';
  #           $wgDefaultSkin = 'citizen';
  #           $wgRawHtml = true;
  #           $wgSmjExtraInlineMath = [ [ "$", "$" ], [ "\\(", "\\)" ] ];
  #           $wgCitizenEnableCJKFonts = true;
  #           $wgCitizenEnableDrawerSiteStats = false;
  #           $wgCitizenShowPageTools = 'login';
  #           $wgHeadScriptCode = <<<'START_END_MARKER'
  #           <script>
  #             document.addEventListener("DOMContentLoaded", function() {
  #             if (document.getElementById("pt-userpage-2")) {
  #               document.querySelectorAll("#siteSub, .page-actions, .citizen-page-footer, .citizen-userMenu")
  #                 .forEach(el => el.style.display = "block");
  #             }
  #             });
  #           </script>
  #     START_END_MARKER;
  #   '';
  #   extensions = {
  #     # some extensions are included and can enabled by passing null
  #     VisualEditor = null;
  #     PageImages = null;
  #     TextExtracts = null;
  #     MultimediaViewer = null;
  #     mathjax = pkgs.fetchzip {
  #       url = "https://github.com/jmnote/SimpleMathJax/archive/refs/tags/v0.8.5.zip";
  #       hash = "sha256-T36iaVe64NMclM+fvAA2NmG/oOLCpesoYkQ8637MQCc=";
  #     };
  #     popups = pkgs.fetchzip {
  #       url = "https://github.com/wikimedia/mediawiki-extensions-Popups/archive/refs/tags/REL1_38.zip";
  #       hash = "sha256-dc7gIcaHhSwPPFnhQYWGb+U5qPWqFHBaawhCI7Kg6pM=";
  #     };
  #     # wikiseo = pkgs.fetchzip {
  #     #   url = "https://github.com/wikimedia/mediawiki-extensions-WikiSEO/archive/refs/tags/v2.7.0.zip";
  #     #   hash = "sha256-dc7gIcaHhSwPPFnhQYWGb+U5qPWqFHBaawhCI7Kg6pM=";
  #     # };
  #     customheader = pkgs.fetchzip {
  #       url = "https://github.com/WikiMANNia/Mediawiki-Extension-HeaderExtension/archive/refs/tags/v3.0.0.zip";
  #       hash = "sha256-WVuo5e/R4Cot8yLzlP1xF0y4J6Mg7dY5Y6peBEmoAZs=";
  #     };
  #     pdfembed = pkgs.fetchzip {
  #       url = "https://github.com/miraheze/PDFEmbed/archive/731a129137f886ed4d663c08353b579ee5126628.zip";
  #       hash = "sha256-8xOrc4hngdUGgEqa1GFNFKb5MS77hP2uoxlPH0lDeIA=";
  #     };
  #     ParserFunctions = pkgs.fetchzip {
  #       url = "https://github.com/wikimedia/mediawiki-extensions-ParserFunctions/archive/refs/tags/REL1_38.zip";
  #       hash = "sha256-NmURCH7HvyjxSGSN+FN+4Z9rnK8ajMCa/RpTbGYB4u8=";
  #     };
  #   };
  #   skins = {
  #     Citizen = pkgs.fetchzip {
  #       url = "https://github.com/StarCitizenTools/mediawiki-skins-Citizen/archive/refs/tags/v2.40.2.zip";
  #       hash = "sha256-g1htaa/TCwR7ZpDx+6QNw1meWCi5DZi2zJL595yB4F4=";
  #     };
  #   };
  # };
}
