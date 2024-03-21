{ config, lib, pkgs, ... }:
 
{
  config = {
    environment.systemPackages = with pkgs; [
      game-devices-udev-rules
      heroic
      lutris
      mangohud
      osu-lazer-bin
      protonup-qt
      steam-rom-manager
    ]
  };
  networking.hostname = "shumer-desktop";
  programs = {
    gamemode.enable = true;
    gamescope.enable = true;
    git = {
      enable = true;
      userName = "Shubadus";
      userEmail = "crshumer@gmail.com";
    };
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      # gamescopeSession.enable = true;
    };
  };
}
