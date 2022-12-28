{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    gnome.gnome-tweaks
    gnomeExtensions.tray-icons-reloaded
  ];
}
