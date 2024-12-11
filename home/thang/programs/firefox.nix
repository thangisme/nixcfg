{
  config,
  pkgs,
  ...
}:
let
in
# shyfox = pkgs.fetchFromGitHub {
#   owner = "Naezr";
#   repo = "ShyFox";
#   rev = "bd41f885f19771b12e23c522ccaafe33af59a1c7";
#   hash = "sha256-w4kaOjz51FYYS58TrPVI/OgZ8At9mbPXj2G3X/N7Lu8=";
# };
# cascade = pkgs.fetchFromGitHub {
#   owner = "cascadefox";
#   repo = "cascade";
#   rev = "8fbe98934fa58f934f7ed5253367396519b320a4";
#   hash = "sha256-GMXSpNaShNu/Bce6TTnlgzGHV8MhHRVICv8hJqMi70w=";
# };
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
      # extraConfig = builtins.readFile "${shyfox}/user.js";
    };
  };

  # home.file.".mozilla/firefox/${config.programs.firefox.profiles.thang.path}/chrome/".source =
  #   "${cascade}/chrome/";
  # home.file.".mozilla/firefox/${config.programs.firefox.profiles.thang.path}/chrome/includes/cascade-colours.css".text =
  #   "";
}
