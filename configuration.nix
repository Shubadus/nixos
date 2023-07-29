# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      #<home-manager/nixos>
      #./home
      ./hardware-configuration.nix
      ./wayland.nix
      ./work.nix
      ./xorg.nix
    ];

  boot = {
    kernelModules = [ "kvm-amd" "kvm-intel"];
    loader = {
      grub = {
        configurationLimit = 5;
        devices = ["nodev"];
        enable = true;
        efiSupport = true;
        useOSProber = true;
      };
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      secrets = {
        "/crypto_keyfile.bin" = null;
      };
      luks.devices."luks-6bec694b-327f-409b-82e6-1c4fb7e51cde" = {
        device = "/dev/disk/by-uuid/6bec694b-327f-409b-82e6-1c4fb7e51cde";
        keyFile = "/crypto_keyfile.bin";
      };
    };
  };

  systemd = {
    user.services = {
      dunst = {
        description = "Dunst notification system";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.dunst}/bin/dunst";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
      polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
    };
  };

  networking.hostName = "xps-nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Indiana/Indianapolis";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cshumer = {
    isNormalUser = true;
    description = "Cody Shumer";
    extraGroups = [ "qemu-libvirtd" "libvirtd" "video" "audio" "disk" "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty
    appimagekit
    brave
    cmake
    docker
    flameshot
    git
    gvfs
    heroic
    imagemagick
    libnotify
    libsForQt5.ark
    libsForQt5.filelight
    libreoffice
    lshw
    lutris
    meson
    mpv
    networkmanagerapplet
    pavucontrol
    pcmanfm-qt
    qbittorrent
    ranger
    surf
    system-config-printer
    tmux
    wget
    zip
    unrar
    unzip
    timeshift
    teamviewer
    virt-manager
    qemu
    remmina

    # Necessary Applicaitions for Window Managers
    btop
    dunst
    lxappearance
    polkit_gnome
    rofi-wayland
    rofi-power-menu

    # Audio
    wireplumber

    # Theming
    gnome.gnome-backgrounds
    libsForQt5.breeze-gtk
    libsForQt5.plasma-workspace-wallpapers
    tela-icon-theme

    # Programming Langauges
    cargo
    go
    libgccjit
    nodejs_20
    (python311.withPackages(ps: with ps; [ psutil ]))
    python311Packages.pip
    poetry
    rustc
    rustup
    rust-analyzer
  ];

  fonts = {
    fonts = with pkgs; [
      (nerdfonts.override { fonts = ["Noto" ];})
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["NotoSansM Nerd Font Mono"];
        serif = ["NotoSerif Nerd Font"];
        sansSerif = ["NotoSans Nerd Font"];
      };
    };
  };

  programs = {
    dconf.enable = true;
    gamemode.enable = true;
    gamescope.enable = true;
    light.enable = true;
    neovim = {
      defaultEditor = true;
      enable = true;
      withRuby = true;
      withPython3 = true;
      withNodeJs = true;
      vimAlias = true;
      viAlias = true;
    };
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      # gamescopeSession.enable = true;
    };
    zsh.enable = true;
  };

  # Have QT follow GTK Themes
  qt = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };

  xdg.icons.enable = true;
  xdg.portal.enable = true;

  services = {
    flatpak.enable = true;
    fwupd.enable = true; # Firmware Updater
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC="performance";
      };
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    printing.enable = true;

    thermald.enable = true; # Temperature Management
  };

  virtualisation = {
    libvirtd.enable = true;
    lxc = {
      enable = true;
    };
    # waydroid.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).

  system.stateVersion = "23.05"; # Did you read the comment?

}

