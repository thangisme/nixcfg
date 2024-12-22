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
    # ags.url = "github:aylur/ags/v2";
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
          inherit inputs;
        };
        modules = [
          ./modules/common.nix
          ./modules/common_non_server.nix
          ./hosts/matrix/configuration.nix
          inputs.spicetify-nix.nixosModules.default
          inputs.catppuccin.nixosModules.catppuccin
        ];
      };

      homeConfigurations."thang@matrix" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { inherit system; };

        extraSpecialArgs = {
          inherit inputs;
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
