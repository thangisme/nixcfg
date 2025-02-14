{
  config,
  pkgs,
  ...
}:
let
  potatofox = builtins.fetchTarball {
    url = "https://codeberg.org/awwpotato/potatofox/archive/0949d70379611242b43f67eb8e67d5279ff369f4.tar.gz";
    sha256 = "1bjfilx704clhbi8rkln1crx5xb58ycvgpl7ajkdqzvd988sgxww";
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
        "general.smoothScroll" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "widget.use-xdg-desktop-portal.file-picker" = 1;
        "svg.context-properties.content.enabled" = true;
        "layout.css.has-selector.enabled" = true;
        "browser.urlbar.suggest.calculator" = true;
        "browser.urlbar.trimHttps" = true;
        "browser.urlbar.trimURLs" = true;
        "widget.gtk.rounded-bottom-corners.enabled" = true;
        "browser.compactmode.show" = true;
        "widget.gtk.ignore-bogus-leave-notify" = 1;
        "browser.formfill.enable" = false;
        "sidebar.revamp" = true;
        "sidebar.verticalTabs" = true;
      };
      # extraConfig = builtins.readFile "${potatofox}/user.js";
    };
  };

  # home.file.".mozilla/firefox/${config.programs.firefox.profiles.thang.path}/chrome/".source =
  #   "${potatofox}/chrome/";
}
