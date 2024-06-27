{
  description = "First Attempt at a flake config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      lib = nixpkgs.lib;
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
  in {
    nixosConfigurations = {
      laptop = lib.nixosSystem {
        modules = [ ./hosts/it-lt-03/default.nix ];
      };
      shumer-desktop = lib.nixosSystem {
        modules = [ ./hosts/shumer-desktop/default.nix ];
      };
    };
    homeConfigurations.cshumer = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
  
      modules = [ ./modules/home/default.nix ];
    };
  };
}

#vim:ft=nix
