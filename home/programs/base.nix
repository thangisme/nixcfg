{ config, ... }: {
  imports = [
    ./kitty.nix
    ./git.nix
    ./fish.nix
    ./neovim/base.nix
    ./spicetify.nix
    ./btop.nix
    ./bat.nix
    ./cava.nix
    ./zathura/base.nix
  ];
}
