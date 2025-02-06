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

    glance = {
      enable = true;
      settings = {
        server.port = 9943;
        branding.hide-footer = true;
        pages = [
          {
            name = "Home";
            columns = [
              {
                size = "small";
                widgets = [
                  {
                    type = "clock";
                    "hour-format" = "24h";
                  }
                  {
                    type = "extension";
                    url = "https://canvasqt.quangthang.workers.dev/";
                    "allow-potentially-dangerous-html" = true;
                    parameters = {
                      canvasURL = "https://portal.uet.vnu.edu.vn/";
                      limit = 5;
                      highlightDays = 3;
                    };
                  }
                ];
              }
              {
                size = "full";
                widgets = [
                  {
                    type = "search";
                    "search-engine" = "duckduckgo";
                  }
                  {
                    type = "bookmarks";
                    groups = [
                      {
                        links = [
                          {
                            title = "UET Portal";
                            url = "https://portal.uet.vnu.edu.vn/";
                          }
                          {
                            title = "Điểm báo - VOZ";
                            url = "https://voz.vn/f/%C4%90iem-bao.33/";
                          }
                        ];
                      }
                      {
                        links = [
                          {
                            title = "Open WebUI";
                            url = "https://llm.thangqt.com";
                          }
                          {
                            title = "O'Reilly";
                            url = "https://login.sjezp01.sjlibrary.org/login?url=https://www.oreilly.com/library-access/";
                          }
                          {
                            title = "CSES";
                            url = "https://cses.fi/problemset/list/";
                          }
                        ];
                      }
                    ];
                  }
                ];
              }
              {
                size = "small";
                widgets = [
                  {
                    type = "extension";
                    url = "https://glancequote.quangthang.workers.dev/";
                    "allow-potentially-dangerous-html" = true;
                  }
                  {
                    type = "weather";
                    location = "Hanoi";
                  }
                ];
              }
            ];
          }
          {
            name = "Feeds";
            columns = [
              {
                size = "small";
                widgets = [
                  {
                    type = "rss";
                    title = "My Custom Feed";
                    limit = 5;
                    "collapse-after" = 3;
                    feeds = [
                      {
                        url = "https://samwho.dev/rss.xml";
                        title = "Samwho.dev";
                      }
                      {
                        url = "https://xeiaso.net/blog.rss";
                        title = "Xeiaso";
                      }
                      {
                        url = "https://jcs.org/rss";
                        title = "jcs";
                      }
                    ];
                  }
                  {
                    type = "videos";
                    style = "grid-cards";
                    limit = 10;
                    collapse-after-rows = 3;
                    channels = [
                      "UCcaTUtGzOiS4cqrgtcsHYWg" # jvscholz
                      "UCn1XB-jvmd9fXMzhiA6IR0w" # Domics
                      "UCdC0An4ZPNr_YiFiYoVbwaw" # Daily dose of internet
                      "UC9-y-6csu5WGm29I7JiwpnA" # Computerphile
                      "UCW8GJoJ1ziO7lRSV7NDZfdg" # We are digital maker
                      "UCDzVUXiTr3hClI-zzCWbYzg" # Spanning tree
                      "UC4QZ_LsYcvcq7qOsOhpAX4A" # Coldfusion
                      "UCR3yKDMd7e5iRBub6oPd6rw" # Cười đi hihi 
                      "UC_zBdZ0_H_jn41FDRG7q4Tw" # Vimjoyer
                      "UCo8bcnLyZH8tBIH9V1mLgqQ" # TheOdd1sOut
                    ];
                  }
                ];
              }
              {
                size = "full";
                widgets = [
                  {
                    type = "hacker-news";
                    limit = 15;
                    "collapse-after" = 5;
                  }
                  {
                    type = "rss";
                    title = "Webdev & Design";
                    limit = 15;
                    feeds = [
                      {
                        url = "https://tympanus.net/codrops/feed/";
                        title = "Codrops";
                      }
                    ];
                  }
                ];
              }
              {
                size = "small";
                widgets = [
                  {
                    type = "lobsters";
                    limit = 15;
                    "collapse-after" = 5;
                    "sort-by" = "hot";
                  }
                ];
              }
            ];
          }
        ];
      };
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


