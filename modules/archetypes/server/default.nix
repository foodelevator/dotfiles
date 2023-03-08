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

    elevate.security.tls-certificates.enable = true;
    elevate.services.nginx.enable = true;
    elevate.services.sshd.enable = true;

    networking.nameservers = [ "1.1.1.1" ];
    # TODO: do i need this? lego started working at
    # the same time as when i added this i think

    security.sudo.wheelNeedsPassword = false;
    # TODO: do i really need this?
    # currently used to deploy

    nix.settings.trusted-users = [ config.elevate.user.name ];
  };
}
