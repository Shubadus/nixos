# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
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
  };

  systemd = {
    user.services = {
    };
  };

  # networking.hostName = "it-vd-03"; # Define your hostname.

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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

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
    home-manager.enable = true;
    light.enable = true;
    neovim = {
      # defaultEditor = true;
      enable = true;
      withRuby = true;
      withPython3 = true;
      withNodeJs = true;
      # vimAlias = true;
      # viAlias = true;
    };
    virt-manager.enable = true;
  };

  environment.systemPackages = with pkgs; [
    ansible
    cmake
    imagemagick
    imv
    libnotify
    lshw
    lunarvim
    mesa
    meson
    mpv
    noisetorch
    ranger
    wget
    zip
    unrar
    unzip

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
    services.auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
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

  system.stateVersion = "23.11"; # Did you read the comment?

}

