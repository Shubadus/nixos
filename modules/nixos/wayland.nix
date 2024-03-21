{ config, lib, pkgs, ... }:
 
{
  config = {
    environment.systemPackages = with pkgs; [
      alacritty
      appimagekit
      auto-cpufreq
      brave
      btop
      cage
      dunst
      grim
      kanshi
      libreoffice
      nwg-displays
      nwg-look
      pavucontrol
      polkit_gnome
      pyprland
      qbittorrent
      slurp
      spotify
      swaybg
      swayimg
      swaylock-effects
      swayidle
      teamviewer
      timeshift
      wireplumber
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
      nm-applet.enable = true;
    };

    security.pam.services.swaylock.fprintAuth = false;

    services = {
      # Display Manager
      # TODO: Look at using regreet instead
      greetd = {
        enabled = true;
        settings = {
          default_session = {
            command = "${cage}/bin/cage gtkgreet"
            user = "greeter"
          };
        };
      };
      gvfs.enable = true; # Mount, trash, and other functionalities for thunar
      tumbler.enable = true; # Thumbnail support for thunar
    };
    environment.etc."greetd/environments".text = ''
      Hyprland
    '';
  };
}
