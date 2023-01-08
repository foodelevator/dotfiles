{ config, pkgs, ... }:
{
  virtualisation.libvirtd.enable = true;

  environment.systemPackages = with pkgs; [
    virt-manager
    gnome.gnome-boxes
  ];
}