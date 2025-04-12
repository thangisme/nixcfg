{ ... } : {
    services.glance = {
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
}
