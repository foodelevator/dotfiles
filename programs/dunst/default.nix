{ config, pkgs, ... }:
{
  xdg.configFile."dunst/dunstrc".source = ./dunstrc;
}
