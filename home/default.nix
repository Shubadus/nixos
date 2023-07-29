{ config, pkgs, ... }:
{
  home-manager.useGlobalPkgs = true;
  home-manager.users.cshumer = {
    gtk = {
      enable = true;
      font.name = "NotoSans Nerd Font 10";
      font.package = pkgs.nerdfonts;
      theme.name = "Breeze-Dark";
      theme.package = pkgs.libsForQt5.breeze-gtk;
      iconTheme.name = "Tela-blue-dark";
      iconTheme.package = pkgs.tela-icon-theme;
    };
    programs.home-manager.enable = true;
    home.stateVersion = "23.05";
  };
}
