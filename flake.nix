{
  description = "First Attempt at a flake config";

  inputs = {
    nixpkgs.url = "github.com:nixos/nixpkgs/nixos-23.11";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

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

    systems = [
      # "aarch64-linux"
      "x86_64-linux"
    ];

    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # Your custom packages and modifications, exported as overlays
    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    # nixosModules = import ./modules/nixos;
    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    # homeManagerModules = import ./modules/home-manager;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    imports = [
      ./modules/nixos/system.nix
      ./modules/nixos/wayland.nix
      ./modules/nixos/work.nix
      ./home/default.nix
    ];
    # nixosConfigurations = {
    #   # FIXME replace with your hostname
    #   "it-vd-03" = nixpkgs.lib.nixosSystem {
    #     specialArgs = {inherit inputs outputs;};
    #     modules = [
    #       # > Our main nixos configuration file <
    #       ./configuration.nix
    #       home-manager.nixosModules.home-manager
    #       {
    #         home-manager.useGlobalPkgs = true;
    #         home-manager.useUserPackages = true;
    #         home-manager.users.cshumer = import ./home/default.nix;
    #       }
    #     ];
    #   };
    # };
  };
}

#vim:ft=nix
