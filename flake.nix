{
  description = "ThangQT's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
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
      nixpkgs-unstable,
      home-manager,
      ...
    }@inputs:
    let
      # Default system set to x86_64-linux
      defaultSystem = "x86_64-linux";
    in
    {
      nixosConfigurations.matrix = nixpkgs-unstable.lib.nixosSystem {
        system = defaultSystem;
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./modules/common.nix
          ./modules/common_non_server.nix
          ./hosts/matrix/configuration.nix
          inputs.agenix.nixosModules.default
          inputs.spicetify-nix.nixosModules.default
          inputs.catppuccin.nixosModules.catppuccin
          {
            environment.systemPackages = [
              inputs.agenix.packages.${defaultSystem}.default
            ];
          }
        ];
      };

      nixosConfigurations.satellite = nixpkgs-unstable.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./modules/common.nix
          ./hosts/satellite/configuration.nix
          inputs.agenix.nixosModules.default
          {
            environment.systemPackages = [
              inputs.agenix.packages."aarch64-linux".default
            ];
          }
        ];
      };

      nixosConfigurations.chalkboard = nixpkgs-unstable.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./modules/common.nix
          ./hosts/chalkboard/configuration.nix
          inputs.agenix.nixosModules.default
          {
            environment.systemPackages = [
              inputs.agenix.packages."aarch64-linux".default
            ];
          }
        ];
      };

      nixosConfigurations.seed = nixpkgs.lib.nixosSystem {
        system = defaultSystem;
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./modules/common.nix
          ./hosts/seed/configuration.nix
          inputs.agenix.nixosModules.default
          {
            environment.systemPackages = [
              inputs.agenix.packages.${defaultSystem}.default
            ];
          }
        ];
      };

      homeConfigurations."thang@matrix" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs-unstable { system = defaultSystem; };
        extraSpecialArgs = {
          inherit inputs;
        };
        modules = [
          inputs.catppuccin.homeManagerModules.catppuccin
          inputs.spicetify-nix.homeManagerModules.default
          ./home/thang/base.nix
        ];
      };
    };
}
