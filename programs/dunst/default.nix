{ config, pkgs, ... }:
{
  xdg.configFile."dunst/dunstrc".source = ./dunstrc;

  home.packages = [ pkgs.dunst ];
}
