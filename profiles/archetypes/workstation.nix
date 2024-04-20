{ pkgs, profiles, ... }:
{
  imports = with profiles; [
    system.networking
    system.printing
    system.sound

    sets.base
    sets.desktop
    sets.ctf
    sets.devops
    sets.gaming
    sets.programming

    cli-apps.ssh
    cli-apps.typst

    virtualisation.oci-containers
    virtualisation.virt-manager

    security.yubikey
  ];

  environment.systemPackages = with pkgs; [
    ffmpeg
    man-pages
  ];

  elevate.apps.syncthing.enable = true;
  elevate.apps.syncthing.homeDirs = true;

  services.mullvad-vpn.enable = true;
  hardware.flipperzero.enable = true;

  elevate.user.groups = [ "dialout" ];
}
