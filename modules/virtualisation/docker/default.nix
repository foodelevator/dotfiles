{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.virtualisation.docker;
in
{
  options.elevate.virtualisation.docker = {
    enable = mkEnableOption "docker";
  };

  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;

    elevate.user.groups = [ "docker" ];
  };
}
