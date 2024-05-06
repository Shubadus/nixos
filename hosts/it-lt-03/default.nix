{ config, pkgs, self, ... }: {
  imports = [
    ./modules/nixos/system.nix
    ./modules/nixos/wayland.nix
  ];
  environment.systemPackages = with pkgs; [
    # Work
    azure-cli
    citrix_workspace
    chromium
    microsoft-edge
    onedrive
    onedrivegui
    remmina
    _1password-gui
    _1password

    # Android
    scrcpy
  ];

  networking.hostname = "it-lt-03";

  programs = {
    git = {
      userName = "Shubadus";
      userEmail = "cshumer@cameronmch.com";
    };
  };
}
