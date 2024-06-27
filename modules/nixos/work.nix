{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Work
    azure-cli
    citrix_workspace
    chromium
    microsoft-edge
    onedrive
    _1password-gui
    _1password

    # Android
    scrcpy
  ];
}
