{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.archetypes.server;
in
{
  options.elevate.archetypes.server = {
    enable = mkEnableOption "indicates that this is a server for serving stuff";
  };

  config = mkIf cfg.enable {
    elevate.sets.base.enable = true;

    elevate.apps.syncthing.enable = true;
    elevate.security.tls-certificates.enable = true;
    elevate.services.nginx.enable = true;
    elevate.services.sshd.enable = true;

    # TODO: do i need this? lego started working at
    # the same time as when i added this i think
    networking.nameservers = [ "1.1.1.1" ];

    # NOTE: Needed for deploying system
    nix.settings.trusted-users = [ config.elevate.user.name ];
    security.sudo.wheelNeedsPassword = false;
  };
}
