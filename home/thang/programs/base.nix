{ config, ... }:
{
  imports = [
    ./kitty.nix
    ./git.nix
    ./fish.nix
    ./spicetify.nix
    ./btop.nix
    ./bat.nix
    ./cava.nix
    ./zathura/base.nix
    ./helix.nix
    ./firefox.nix
    ./direnv.nix
    ./zellij/base.nix
    ./touchegg.nix
  ];
}
