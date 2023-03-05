{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.archetypes.workstation;
in
{
  options.elevate.archetypes.workstation = {
    enable = mkEnableOption "indicates that the machine is used to do stuff";
  };

  config = mkIf cfg.enable {
    elevate.sets.base.enable = true;
    elevate.sets.ctf.enable = true;
    elevate.sets.desktop.enable = true;
    elevate.sets.gaming.enable = true;
    elevate.sets.programming.enable = true;

    environment.systemPackages = with pkgs; [
      ffmpeg
    ];

    elevate.apps.syncthing.enable = true;
    elevate.security.yubikey.enable = true;
    elevate.system.printing.enable = true;
    elevate.system.networking.enable = true;
    elevate.virtualisation.docker.enable = true;
    elevate.virtualisation.virt-manager.enable = true;

    elevate.user = {
      groups = [ "dialout" ];
    };
  };
}
