{ config, lib, pkgs, ... }:
 
{
  config = {
    environment.systemPackages = with pkgs; [
      ags
      alacritty
      appimagekit
      brave
      btop
      grim
      libreoffice
      pavucontrol
      polkit_gnome
      qbittorrent
      slurp
  
      # Hyprland specific
      dunst
      hyprpaper
      hyprshot
      hyprlock
      hypridle
      hyprpicker
      hyprcursor
      hyprlandPlugins = {
        hyprexpo
        hyprbars
      }
      kanshi
      pyprland
      nwg-displays
      nwg-look
      swww
      wlogout
      wl-clipboard
      wofi

      # DM
      cage
      greetd.greetd
      greetd.regreet

      teamviewer
      timeshift
      wireplumber

      # Themeing
      nerdfonts
      libsForQt5.breeze-gtk
      libsForQt5.plasma-workspace-wallpapers
      materia-theme
      nordic
      tela-icon-theme
    ];

    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    programs = {
      hyprland = {
        enable = true;
        xwayland.enable = true;
      };
      nm-applet.enable = true;
      starship.enable = true;
      thunar = {
        enable = true;
        plugins = with pkgs.xfce; [
          thunar-archive-plugin
          thunar-volman
        ]
      };
      waybar.enable = true;
    };

    security.pam.services.swaylock.fprintAuth = false;

    services = {
      blueman.enable = true;
      # Display Manager
      # TODO: Look at using regreet instead
      greetd = {
        enabled = true;
        settings = {
          default_session = {
            command = "${cage}/bin/cage regreet"
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
