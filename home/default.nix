{ 
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home= {
    username = "cshumer";
    homeDirectory = "/home/cshumer";
  };

  programs = {
    dconf.enable = true;
    gamemode.enable = true;
    gamescope.enable = true;
    git = {
      enable = true;
      userName = "Shubadus";
      userEmail = "cshumer@cameronmch.com"
    };
    home-manager.enable = true;
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
  };

  home.packages = with pkgs; [
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


  home-manager.useGlobalPkgs = true;
  home-manager.users.cshumer = {
    gtk = {
      enable = true;
      font.name = "NotoSans Nerd Font 10";
      font.package = pkgs.nerdfonts;
      theme.name = "Materia-dark-compact";
      theme.package = pkgs.materia-kde-theme;
      iconTheme.name = "Tela-blue-dark";
      iconTheme.package = pkgs.tela-icon-theme;
    };
  };

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.11";
}
