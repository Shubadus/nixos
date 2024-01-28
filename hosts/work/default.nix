{ config, pkgs, self, ... }: {
  environment.systemPackages = with pkgs; [
    # Work
    azure-cli
    citrix_workspace
    chromium
    microsoft-edge
    onedrive
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
