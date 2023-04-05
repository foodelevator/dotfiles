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

    # TODO: do i need this? lego started working at
    # the same time as when i added this i think
    networking.nameservers = [ "1.1.1.1" ];

    # NOTE: Needed to deploy with deploy-rs
    security.sudo.wheelNeedsPassword = false;
    nix.settings.trusted-users = [ config.elevate.user.name "deploy" ];

    # User used by github actions to deploy websites
    users.users.deploy = {
      isSystemUser = true;
      group = "deploy";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPO4K+TH/92mNXJ1w5yDO5wQSbhb2nj+wGvfXel/NjQT deploy@magnusson.space"
      ];
      shell = pkgs.bashInteractive;
    };
    users.groups.deploy = {};
    security.sudo.extraRules = [{
      groups = [ "deploy" ];
      commands = [{ command = "/run/current-system/sw/bin/systemctl restart *"; options = [ "NOPASSWD" ]; }];
    } {
      groups = [ "deploy" ];
      runAs = "mathias"; # TODO: this isn't very good, should use website specific accounts
      commands = [{ command = "ALL"; options = [ "NOPASSWD" ]; }];
    }];
  };
}
