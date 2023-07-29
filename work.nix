{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Work
    azure-cli
    # citrix_workspace
    chromium
    microsoft-edge
    onedrive
    _1password-gui
    _1password

    # Android
    scrcpy
  ];

  systemd = {
    user.services = {
      remmina = {
        description = "Remmina";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.remmina}/bin/remmina -i";
        };
      };
      onepassword = {
        description = "1password";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs._1password-gui}/bin/1password --silent";
        };
      };
    };
  };
}
