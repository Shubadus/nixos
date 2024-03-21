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
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    lib = nixpkgs.lib;

  in {
    imports = [
      ./modules/nixos/system.nix
      ./modules/nixos/wayland.nix
      ./modules/home/default.nix
    ];
  };
}

#vim:ft=nix
