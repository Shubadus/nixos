{ 
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # imports = [
  #   ./hyprland
  #   ./programs
  # ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home= {
    username = "cshumer";
    homeDirectory = "/home/cshumer";
    stateVersion = "24.05";
  };

  home-manager.useGlobalPkgs = true;
  home-manager.users.cshumer = {
    # gtk = {
    #   enable = true;
    #   font.name = "NotoSans Nerd Font 10";
    #   font.package = pkgs.nerdfonts;
    #   theme.name = "Materia-dark-compact";
    #   theme.package = pkgs.materia-theme;
    #   iconTheme.name = "Tela-blue-dark";
    #   iconTheme.package = pkgs.tela-icon-theme;
    # };
  };


  # systemd.user.startServices = "sd-switch";
}
