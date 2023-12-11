{ config, lib, pkgs, ... }:
 
{
  config = {
    systemd = {
      user.services = {
        swayidle = {
          description = "swayidle";
          wantedBy = [ "graphical-session.target" ];
          serviceConfig = {
            Type = "simple";
            ExecStart = "${pkgs.swayidle}/bin/swayidle";
          };
        };
      };
    };

    environment.systemPackages = with pkgs; [
      gtklock
      gtklock-userinfo-module
      gtklock-powerbar-module
      gtklock-playerctl-module
      kanshi
      nwg-look
      nwg-displays
      swaybg
      swayimg
      # swaylock-effects
      swayidle
      swaynotificationcenter
      # wdisplays
      wlogout
      wl-clipboard
      wl-gammactl
      wofi

      libsForQt5.breeze-gtk
      libsForQt5.plasma-workspace-wallpapers
      nordic
      tela-icon-theme
    ];
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    programs = {
      sway = {
        enable = true;
        # package = pkgs.swayfx;
        extraPackages = with pkgs; [
          autotiling
          nwg-bar
          nwg-dock
          nwg-drawer
          nwg-launchers
        ];
      };
      hyprland = {
        enable = true;
        enableNvidiaPatches = true;
        xwayland.enable = true;
        xwayland.hidpi = true;
      };
      waybar.enable = true;
    };

    # security.pam.services.swaylock.fprintAuth = false;
    security.pam.services.gtklock = {};

    services = {
      xserver.enable = true;
      xserver.displayManager.sddm = {
        enable = true;
        theme = "Materia-dark-compact";
        wayland.enable = true;
      };
    };
  };
}
