{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    (import ../../modules/agenix.nix { hostName = "seed"; })
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/efi";
  swapDevices = [
    {
      device = "/swapfile";
      size = 2 * 1024;
    }
  ];
  boot.kernelParams = [
    "console=ttyS0,115200n8"
    "console=tty0"
  ];

  networking.hostName = "seed";

  services.openssh = {
    enable = true;
    ports = [ 2222 ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };

  # Default shell
  users.users.thang = {
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHZ7KokkDS4XU9M15R3htHbt4ZJ9NQeYxVbKWinbE3n5"
    ];
  };

  system.stateVersion = "24.11";

  environment.systemPackages = with pkgs; [
    helix
  ];

  # Fish
  programs.fish.enable = true;

  networking = {
    firewall = rec {
      enable = true;
      allowedTCPPorts = [
        2222
        80
        443
      ];
      allowedUDPPorts = allowedTCPPorts;
    };
  };

  services.tailscale.enable = true;

  security.acme.defaults.email = "thang@thang.com";
  security.acme.acceptTerms = true;

  services.caddy = {
    enable = true;
    virtualHosts."vault.thangqt.com".extraConfig = ''
      tls internal
      reverse_proxy http://127.0.0.1:9182 {
        header_up X-Real-IP {http.request.header.Cf-Connecting-Ip}
      }
    '';
  };

  services.vaultwarden = {
    enable = true;
    dbBackend = "sqlite";
    backupDir = "/var/backup/vaultwarden";
    environmentFile = config.age.secrets.vaultwarden_env.path;
    config = {
      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 9182;
      DOMAIN = "https://vault.thangqt.com";
    };
  };
}
