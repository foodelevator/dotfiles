{ config, pkgs, ... }:
{
  home.packages = [
    pkgs.gnome.gnome-tweaks
  ] ++ (with pkgs.gnomeExtensions; [
    tray-icons-reloaded
    syncthing-icon
  ]);
}
