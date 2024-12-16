{ config, ... }:
{
  services.mako = {
    enable = true;
    font = "Iosevka Nerd Font 12";
    iconPath = "/home/thang/.nix-profile/share/icons/Papirus-Dark";
    maxIconSize = 48;
    defaultTimeout = 5000;
    layer = "overlay";
    margin = "8";
    padding = "12";
    width = 420;
    height = 200;
    borderSize = 1;
    borderRadius = 4;
    borderColor = "#424242";
    backgroundColor = "#11111b";
    textColor = "#cdd6f4";
    progressColor = "over #1e1e2e";

    extraConfig = ''
      [urgency=critical]
      border-color=#f38ba8
      default-timeout=0
    '';
  };
}
