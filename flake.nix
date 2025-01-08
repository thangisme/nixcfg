{
  description = "ThangQT's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix.url = "github:ryantm/agenix";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.matrix = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs system;
        };
        modules = [
          ./modules/common.nix
          ./modules/common_non_server.nix
          ./hosts/matrix/configuration.nix
          inputs.agenix.nixosModules.default
          inputs.spicetify-nix.nixosModules.default
          inputs.catppuccin.nixosModules.catppuccin
        ];
      };

      nixosConfigurations.windy= nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs system;
        };
        modules = [
          ./modules/common.nix
          ./hosts/windy/configuration.nix
          inputs.agenix.nixosModules.default
        ];
      };

      homeConfigurations."thang@matrix" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { inherit system; };

        extraSpecialArgs = {
          inherit inputs system;
        };

        modules = [
          # inputs.ags.homeManagerModules.default
          inputs.catppuccin.homeManagerModules.catppuccin
          inputs.spicetify-nix.homeManagerModules.default
          ./home/thang/base.nix
        ];
      };
    };
}
