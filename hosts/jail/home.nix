{
  config,
  pkgs,
  lib,
  ...
}:

{
  nixpkgs.config.allowUnfreePredicate = (_: true);

  home.username = "thang";
  home.homeDirectory = "/home/thang";
  home.packages = with pkgs; [
  ];

  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };

  home.stateVersion = "24.11";

  imports = [
    ../../modules/home/git.nix
    ../../modules/home/fish.nix
    ../../modules/home/helix.nix
    ../../modules/home/zellij/base.nix
  ];

  programs.helix.settings.theme = lib.mkForce "mocha_transparent";
}
