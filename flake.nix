{
  description = "ThangQT's NixOS configuration";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin = {
      url = "github:catppuccin/nix";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      catppuccin,
      ...
    }:
    {
      nixosConfigurations = {
        matrix = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            (
              { config, pkgs, ... }:
              {
                nixpkgs.overlays = [
                  (final: prev: {
                    unstable = import nixpkgs-unstable {
                      system = "x86_64-linux";
                      config = {
                        allowUnfree = true;
                      };
                    };
                  })
                ];
              }
            )
            ./modules/common.nix
            ./modules/common_non_server.nix
            ./hosts/matrix/configuration.nix
            catppuccin.nixosModules.catppuccin
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "bak";

              home-manager.users.thang.imports = [
                ./home/thang/base.nix
                catppuccin.homeManagerModules.catppuccin
              ];
            }
          ];
        };
      };
    };
}
