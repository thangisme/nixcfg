{ config, pkgs, ... }:
{

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 15;

  # Optimize boot time
  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Ho_Chi_Minh";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "vi_VN";
    LC_IDENTIFICATION = "vi_VN";
    LC_MEASUREMENT = "vi_VN";
    LC_MONETARY = "vi_VN";
    LC_NAME = "vi_VN";
    LC_NUMERIC = "vi_VN";
    LC_PAPER = "vi_VN";
    LC_TELEPHONE = "vi_VN";
    LC_TIME = "vi_VN";
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "monthly";
    options = "--delete-older-than 30d";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Help run non-nix excutable
  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    curl
    git
  ];

  users.users.thang = {
    isNormalUser = true;
    description = "Quang Thang";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
