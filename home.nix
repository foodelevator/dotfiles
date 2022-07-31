{ config, pkgs, ... }:
{
  xdg.configFile."dunst/dunstrc".source = ./programs/dunst/dunstrc;

  home.homeDirectory = "/home/mathias";
  home.username = "mathias";
  home.stateVersion = "22.11";
}
