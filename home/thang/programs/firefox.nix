{
  config,
  pkgs,
  ...
}:
let
  shyfox = pkgs.fetchFromGitHub {
    owner = "Naezr";
    repo = "ShyFox";
    rev = "bd41f885f19771b12e23c522ccaafe33af59a1c7";
    hash = "sha256-w4kaOjz51FYYS58TrPVI/OgZ8At9mbPXj2G3X/N7Lu8=";
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
      extraConfig = builtins.readFile "${shyfox}/user.js";
    };
  };

  home.file.".mozilla/firefox/${config.programs.firefox.profiles.thang.path}/chrome".source = "${shyfox}/chrome";
}
