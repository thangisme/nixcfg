{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernel.sysctl."kernel.sysrq" = 1;
  boot.loader.efi.efiSysMountPoint = "/efi";
  boot.kernelParams = [ "console=ttyS0,115200n8" "console=tty0" ];

  networking.hostName = "windy";

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
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHZ7KokkDS4XU9M15R3htHbt4ZJ9NQeYxVbKWinbE3n5" ];
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
    virtualHosts."search.thangqt.com".extraConfig = ''
      tls internal
      reverse_proxy http://127.0.0.1:5326
    '';
    virtualHosts."llm.thangqt.com".extraConfig = ''
      tls internal
      reverse_proxy http://127.0.0.1:2855
    '';
  };

  services.whoogle-search = {
    enable = true;
    port = 5326;
    extraEnv = {
      WHOOGLE_CONFIG_STYLE = ":root{--whoogle-logo:#4c4f69;--whoogle-page-bg:#eff1f5;--whoogle-element-bg:#bcc0cc;--whoogle-text:#4c4f69;--whoogle-contrast-text:#5c5f77;--whoogle-secondary-text:#6c6f85;--whoogle-result-bg:#ccd0da;--whoogle-result-title:#7287fd;--whoogle-result-url:#dc8a78;--whoogle-result-visited:#e64553;--whoogle-dark-logo:#cdd6f4;--whoogle-dark-page-bg:#1e1e2e;--whoogle-dark-element-bg:#45475a;--whoogle-dark-text:#cdd6f4;--whoogle-dark-contrast-text:#bac2de;--whoogle-dark-secondary-text:#a6adc8;--whoogle-dark-result-bg:#313244;--whoogle-dark-result-title:#b4befe;--whoogle-dark-result-url:#f5e0dc;--whoogle-dark-result-visited:#eba0ac}#whoogle-w{fill:#89b4fa}#whoogle-h{fill:#f38ba8}#whoogle-o-1{fill:#f9e2af}#whoogle-o-2{fill:#89b4fa}#whoogle-g{fill:#a6e3a1}#whoogle-l{fill:#f38ba8}#whoogle-e{fill:#f9e2af}";
    };
  };

  services.open-webui = {
    enable = true;
    port = 2855;
    environmentFile = config.age.secrets.openwebui_env.path;
  };
}
