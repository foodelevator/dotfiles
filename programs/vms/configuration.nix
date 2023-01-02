{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gnome.gnome-boxes
  ];
}
