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
    # open-webui = {
    #   enable = true;
    #   port = 2855;
    #   environmentFile = config.age.secrets.openwebui_env.path;
    # };

    glance = {
      enable = true;
      settings = {
        server.port = 9943;
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
                            title = "Example";
                            url = "example.com";
                          }
                          {
                            title = "Example";
                            url = "example.com";
                          }
                          {
                            title = "Example";
                            url = "example.com";
                          }
                        ];
                      }
                      {
                        title = "Another";
                        links = [
                          {
                            title = "Example";
                            url = "example.com";
                          }
                          {
                            title = "Example";
                            url = "example.com";
                          }
                          {
                            title = "Example";
                            url = "example.com";
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
                    collapse-after-rows = 6;
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
                    type = "group";
                    title = "News";
                    widgets = [
                      {
                        type = "rss";
                        title = "General News";
                        limit = 5;
                        feeds = [
                          {
                            url = "https://www.economist.com/feeds/print-sections/77/science-and-technology.xml";
                            title = "Economist";
                          }
                          {
                            url = "https://www.theguardian.com/world/rss";
                            title = "The Guardian";
                          }
                        ];
                      }
                      {
                        type = "rss";
                        title = "Tech News";
                        limit = 5;
                        feeds = [
                          {
                            url = "https://www.techradar.com/rss";
                            title = "TechRadar";
                          }
                          {
                            url = "https://www.wired.com/feed/rss";
                            title = "Wired";
                          }
                        ];
                      }
                      {
                        type = "rss";
                        title = "OSS News";
                        limit = 5;
                        feeds = [
                          {
                            url = "https://opensource.com/feed";
                            title = "OpenSource.com";
                          }
                        ];
                      }
                      {
                        type = "rss";
                        title = "Voz";
                        limit = 5;
                        feeds = [
                          {
                            url = "https://voz.vn/f/%C4%90iem-bao.33/index.rss";
                            title = "Điểm báo - Voz";
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
                    type = "group";
                    widgets = [
                      {
                        type = "hacker-news";
                        limit = 15;
                        "collapse-after" = 5;
                      }
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

