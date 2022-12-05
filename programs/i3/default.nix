{ config, pkgs, ... }:
{
  xdg.configFile."i3/config".source = ./config;
  xdg.configFile."i3/i3blocks".source = ./i3blocks;

  home.packages = with pkgs; [
    i3blocks
    i3lock-fancy
  ];
}
