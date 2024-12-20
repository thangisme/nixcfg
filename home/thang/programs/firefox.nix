{
  config,
  pkgs,
  ...
}:
let
  potatofox = builtins.fetchTarball {
    url = "https://codeberg.org/awwpotato/potatofox/archive/56df7fd6ecba5981f39a94f7628a19cc22839a68.tar.gz";
    sha256 = "13vnzrjxmlq656iw83dndadp502808f595wqpmm30987dglb781m";
  };
in
{
  programs.firefox = {
    enable = true;
    profiles.thang = {
      settings = {
        "apz.overscroll.enabled" = true;
        "browser.aboutConfig.showWarning" = false;
        "general.autoScroll" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
      extraConfig = builtins.readFile "${potatofox}/user.js";
    };
  };

  home.file.".mozilla/firefox/${config.programs.firefox.profiles.thang.path}/chrome/".source =
    "${potatofox}/chrome/";
}
