{ inputs, pkgs, ... }:
{
  programs.ags = {
    enable = true;
    configDir = ./.;

    extraPackages = with pkgs; [
      inputs.ags.packages.${pkgs.system}.battery
      fzf
    ];
  };
}
