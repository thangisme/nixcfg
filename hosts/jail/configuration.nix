{ config, pkgs, lib, ... }:

{
  wsl.enable = true;
  wsl.defaultUser = "thang";
  
  networking.hostName = "leaf";

  users.users.thang = {
    shell = pkgs.fish;
  };

  environment.systemPackages = with pkgs; [
    home-manager
    helix
    zoxide
    direnv
    nix-your-shell
    fastfetch
    btop
    fzf
    lazygit
    uv
  ];

  programs.fish.enable = true;

  system.stateVersion = "24.11";
}

