{
  config,
  pkgs,
  lib,
  ...
}:

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

  environment.localBinInPath = true;

  programs.fish.enable = true;

  # For VSCode remote server to work
  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;

  };
  system.stateVersion = "24.11";
}
