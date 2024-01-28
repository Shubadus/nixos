{ config, lib, pkgs, ... }:
 
{
  config = {
    systemd = {
      user.services = {
        # swayidle = {
        #   description = "swayidle";
        #   wantedBy = [ "graphical-session.target" ];
        #   serviceConfig = {
        #     Type = "simple";
        #     ExecStart = "${pkgs.swayidle}/bin/swayidle";
        #   };
        # };
      };
    };

    environment.systemPackages = with pkgs; [
      kanshi
      swaybg
      swayimg
      swaylock-effects
      swayidle
      swaynotificationcenter
      nwg-displays
      nwg-look
      wlogout
      wl-clipboard
      wl-gammactl
      wofi

      libsForQt5.breeze-gtk
      libsForQt5.plasma-workspace-wallpapers
      materia-theme
      materia-kde-theme
      nordic
      tela-icon-theme
    ];
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    programs = {
      hyprland = {
        enable = true;
        xwayland.enable = true;
      };
      waybar.enable = true;
      thunar = {
        enable = true;
        plugins = with pkgs.xfce; [
          thunar-archive-plugin
          thunar-volman
        ]
      };
    };

    security.pam.services.swaylock.fprintAuth = false;

    services = {
      greetd = {
        enabled = true;
        settings = {
          default_session = {
            command = "${lib.makeBinPath [ pkgs.greetd.tuigreet ]}/tuigreet \
              -r --asterisks --time --cmd ${runner}"
          };
        };
      };
      gvfs.enable = true; # Mount, trash, and other functionalities for thunar
      tumbler.enable = true; # Thumbnail support for thunar
      # xserver.enable = true;
      # xserver.displayManager.gdm = {
      #   enable = true;
      #   wayland = true;
      # };
    };
  };
}
