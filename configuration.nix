# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      #<home-manager/nixos>
      #./home
      ./hosts/shumer-desktop/default.nix
      ./modules/nixos/wayland.nix
      ./modules/nixos/work.nix
      ./hardware-configuration.nix
    ];

  # nix.settings = {
  #   experimental-features = [ "nix-command"  "flakes" ];
  #   auto-optimise-store = true;
  # };
  # nix.registry = (
  #   lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs
  # );

  # nix.nixPath = ["/etc/nix/path"];
  # environment.etc =
  #   lib.mapAttrs'
  #   (name: value: {
  #     name = "nix/path/${name}";
  #     value.source = value.flake;
  #   })
  #   config.nix.registry;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cshumer = {
    isNormalUser = true;
    description = "Cody Shumer";
    extraGroups = [ "qemu-libvirtd" "libvirtd" "video" "audio" "disk" "networkmanager" "wheel" ];
    # shell = pkgs.zsh;
  };
}

