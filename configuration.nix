{ config, pkgs, nixpkgs-unstable, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "matrix";

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

  # Desktop Environment.
  services.xserver = {
    enable = true;

    displayManager.gdm = {
      enable = true;
      wayland = true;
    };

    #displayManager.sddm = {
    #  enable = true;
    #  wayland.enable = true;
    #};
    displayManager.defaultSession = "hyprland";

    #desktopManager.plasma5.enable = true;

    excludePackages = with pkgs; [ xterm ];

  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      libsForQt5.fcitx5-qt
      fcitx5-configtool
      fcitx5-unikey
    ];
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
  services.blueman.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # XDG Portal
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Polkit
  security.polkit.enable = true;

  # Ignore pwoer button
  services.logind.extraConfig = ''
    # don’t shutdown when power button is short-pressed
    HandlePowerKey=ignore
  '';

  users.users.thang = {
    isNormalUser = true;
    description = "Quang Thang";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [

    ];
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  services.envfs.enable = true;

  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  hardware.opengl = {
    # Mesa 
    enable = true;

    # Vulkan
    driSupport = true;
  };
  
  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };


  # Help run non-nix excutable
  programs.nix-ld.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    cron
    neofetch
    neovim
    wget
    python3
    libsForQt5.qtstyleplugin-kvantum
  ];

  # Power management
  powerManagement.enable = true;
  services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;

       #Optional helps save long term battery health
       START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
       STOP_CHARGE_THRESH_BAT0 = 95; # 80 and above it stops charging

      };
  };

  system.stateVersion = "23.11";

  # Fish
  programs.fish.enable = true;

  # Hyprland
  programs.hyprland = {
    enable = true;
    package = pkgs.unstable.hyprland;
    xwayland.enable = true;
  };

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  programs.file-roller.enable = true;

  services.tailscale.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    corefonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    font-awesome
    (nerdfonts.override { fonts = [ "Iosevka" "IosevkaTerm" "DroidSansMono" "NerdFontsSymbolsOnly" ]; })
  ];

}
