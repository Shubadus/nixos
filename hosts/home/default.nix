{ config, lib, pkgs, ... }:
 
{
  config = {
    environment.systemPackages = with pkgs; [
      heroic
      lutris
    ]
  };
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
