{ config, pkgs, ... }:

{
  systemd = {
    user.services = {
      i3lock = {
        description = "i3lock";
        wantedBy = [ "sleep.target" "suspend.target" "hibernate.target" ];
        before = [ "sleep.target" "suspend.target" "hibernate.target" ];
        serviceConfig = {
          Type = "forking";
          Environment = "Display=:0";
          ExecStart = "/usr/bin/lock -l";
        };
      };
    };
  };
  environment.systemPackages = with pkgs; [
    arandr
    deadd-notification-center
    lxappearance
    plank
    nitrogen
  ];

  programs = {
    i3lock = {
      enable = true;
      package = pkgs.i3lock-color;
    };
  };

  services = {
    autorandr.enable = true;
    picom = {
      enable = true;
      settings = {
        shadow-radius = 7;
        shadow-opacity = .75;
        shadow-offset-x = -7;
        shadow-offset-y = -7;
        shadow-exclude = [
          "window_type = 'dock'"
          "name = 'Notification'"
          "class_g ?= 'Notify-osd'"
          "name = 'Plank'"
          "name = 'Docky'"
          "name = 'Kupfer'"
          "name = 'xfce4-notifyd'"
          "name *= 'VLC'"
          "name *= 'compton'"
          "name *= 'Chromium'"
          "name *= 'Chrome'"
          "class_g = 'Firefox' && argb"
          "class_g = 'Conky'"
          "class_g = 'Kupfer'"
          "class_g = 'Synapse'"
          "class_g ?= 'Notify-osd'"
          "class_g ?= 'Cairo-dock'"
          "class_g = 'Cairo-clock'"
          "class_g ?= 'Xfce4-notifyd'"
          "class_g ?= 'Xfce4-power-manager'"
          "_GTK_FRAME_EXTENTS@:c"
        ];

        fading = false;
        fade-in-step = 0.03;
        fade-out-step = 0.03;
        fade-exclude = [
          "window_type = 'dock'"
          "class_g ?= 'Cairo-dock'"
          "class_g = 'Cairo-clock'"
        ];

        inactive-opacity-override = false;
        focus-exclude = [ 
          "window_type = 'dock'"
          "class_g ?= 'Cairo-dock'"
          "class_g = 'Cairo-clock'"
        ];

        opacity-rule = [
          "90:class_g = 'Alacritty'"
        ];

        blur = {
          method = "dual_kawase";
          strength = 15;
        };
        blur-kern = "3x3box";
        blur-background-exclude = [
          "window_type = 'dock'"
          "class_g = '1Password'"
          "class_g = 'Arandr'"
          "class_g = 'Ark'"
          "class_g = 'Cisco AnyConnect Secure Mobility Client'"
          "class_g ?= 'Cairo-dock'"
          "class_g = 'Cairo-clock'"
          "class_g = 'Dunst'"
          "class_g = 'firefox'"
          "class_g *= 'Gimp'"
          "class_g = 'Lxappearance'"
          "class_g = 'obsidian'"
          "class_g = 'org.remmina.Remmina'"
          "class_g = 'pcmanfm-qt'"
          "class_g = 'Plank'"
          "class_g = 'qt5ct'"
          "class_g = 'teams-for-linux'"
          "class_g = 'Timeshift-gtk'"
          "class_g = 'Spotify'"
          "class_g = 'Variety'"
          "class_g = 'Virt-manager'"
          "name *= 'Chromium'"
          "name *= 'Chrome'"
          "QTILE_INTERNAL:32c = 1" # qtile bar
        ];

        backend = "glx";
        vsync = true;
        glx-copy-from-front = true;
        glx-swap-method = 2;
        mark-wmwin-focused = true;
        mark-ovredir-focused = true;
        corner-radius=10;
        rounded-corners-exclude = [
          "window_type = 'maximized'"
          "window_type = 'dock'"
          "class_g = 'URxvt'"
          "class_g = 'XTerm'"
          "class_g = 'code-oss'"
          "class_g = 'Thunderbird'"
          "QTILE_INTERNAL:32c = 1" # qtile bar
        ];
        round-borders = 1;
        detect-rounded-corners = true;
        detect-client-opacity = true;
        detect-transient = true;
        detect-client-leader = true;
        use-damage = true;
        log-level = "warn";

        wintypes = {
          tooltip = { fade = true; shadow = true; opacity = 0.9; focus = true; full-shadow = false; };
          dock = { shadow = false; };
          dnd = { shadow = false; };
          popup_menu = { opacity = 0.9; };
          dropdown_menu = { opacity = 0.9; };
        };
      };
    };

    xserver = {
      enable = true;
      layout = "us";
      libinput = {
        mouse.accelProfile = "flat";
        touchpad = {
          disableWhileTyping = true;
          accelProfile = "adaptive";
        };
      };
      windowManager.qtile = {
        enable = true;
        extraPackages = python311Packages: with python311Packages; [
          qtile-extras
        ];
        backend = "wayland";
      };
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
    };
  };

  xdg.portal = {
    extraPortals = with pkgs; [
      libsForQt5.xdg-desktop-portal-kde
      xdg-desktop-portal-gtk
    ];
  };
}
