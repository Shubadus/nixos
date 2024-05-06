{
  description = "First Attempt at a flake config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    hyprland,
    ...
  } @ inputs: let
    inherit (self) outputs;

      system = "x86_64-linux";
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      # pkgs = import nixpkgs {
      #   inherit system;
      #   config = {
      #     allowUnfree = true;
      #   };
      # };
      lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      it-vd-03 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit system };
        modules = [ default.nix ./hosts/it-lt-03 ];
      };
      shumer-desktop = {
        specialArgs = { inherit system };
        modules = [ default.nix ./hosts/shumer-desktop ];
      }
    };
  };
  homeConfigurations.cshumer = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
  
    modules = [ ./modules/home/default.nix ];
  };
}

#vim:ft=nix
