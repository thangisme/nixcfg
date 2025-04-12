{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/services/glance.nix
  ];

  system = {
    stateVersion = "24.11";
  };

  boot.tmp.cleanOnBoot = true;
  
  networking = {
    hostName = "satellite";
    firewall = rec {
      enable = true;
      allowedTCPPorts = [
        2222
        80
        443
        51820
      ];
      allowedUDPPorts = allowedTCPPorts;
    };
  };

  nixpkgs.overlays = [
    (final: prev: {
      pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
        (
          _: python-prev: {
            rapidocr-onnxruntime = python-prev.rapidocr-onnxruntime.overridePythonAttrs (self: {
              pythonImportsCheck = if python-prev.stdenv.isLinux && python-prev.stdenv.isAarch64 then [] else ["rapidocr_onnxruntime"];
              doCheck = !(python-prev.stdenv.isLinux && python-prev.stdenv.isAarch64);
              meta = self.meta // { badPlatforms = []; broken = false; };
            });

            chromadb = python-prev.chromadb.overridePythonAttrs (self: {
              pythonImportsCheck = if python-prev.stdenv.isLinux && python-prev.stdenv.isAarch64 then [] else ["chromadb"];
              doCheck = !(python-prev.stdenv.isLinux && python-prev.stdenv.isAarch64);
              meta = self.meta // { broken = false; };
            });

            langchain-chroma = python-prev.langchain-chroma.overridePythonAttrs (_: {
              pythonImportsCheck = if python-prev.stdenv.isLinux && python-prev.stdenv.isAarch64 then [] else ["langchain_chroma"];
              doCheck = !(python-prev.stdenv.isLinux && python-prev.stdenv.isAarch64);
            });
          }
        )
      ];
    })
  ];

  services = {
    openssh = {
      enable = true;
      ports = [ 2222 ];
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        UseDns = true;
        X11Forwarding = false;
        PermitRootLogin = "prohibit-password";
      };
    };

    tailscale = {
      enable = true;
    };

    caddy = {
      enable = true;
      user = "www-data";
      group = "www-data";
      virtualHosts = {
        "llm.thangqt.com".extraConfig = ''
          tls internal
          reverse_proxy http://127.0.0.1:2855
        '';
        "glance.thangqt.com".extraConfig = ''
          tls internal
          reverse_proxy http://127.0.0.1:9943
        '';
      };
    };

    open-webui = {
      enable = true;
      port = 2855;
      environmentFile = config.age.secrets.openwebui_env.path;
    };
  };

  security.acme = {
    defaults.email = "thang@thang.com";
    acceptTerms = true;
  };

  users = {
    users = {
      "thang" = {
        shell = pkgs.fish;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHZ7KokkDS4XU9M15R3htHbt4ZJ9NQeYxVbKWinbE3n5"
        ];
        extraGroups = [ "podman" ];
      };
      "www-data" = {
        isSystemUser = true;
        createHome = true;
        home = "/var/www";
        group = "www-data";
      };
    };
    groups."www-data" = { };
  };

  environment = {
    systemPackages = with pkgs; [
      helix
    ];
  };

  programs.fish.enable = true;
}


