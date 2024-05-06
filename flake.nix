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
      lib = nixpkgs.lib;
      # pkgs = import nixpkgs {
      #   inherit system;
      #   config = {
      #     allowUnfree = true;
      #   };
      # };

      nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

      nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

      home-manager = {
        url = "github:nix-community/home-manager/release-23.11";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      hyprland.url = "github:hyprwm/Hyprland";
  in {
    nixosConfigurations = {
      it-vd-03 = lib.nixosSystem {
        modules = [ ./hosts/it-lt-03/default.nix ];
      };
     nixos = lib.nixosSystem {
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
