{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.websites.faktura;
in
{
  options.elevate.websites.faktura = {
    enable = mkEnableOption "Website for Fakturamaskinen";
    port = mkOption {
      type = types.port;
      default = 7000;
    };
    package = mkOption {
      type = with types; either package str;
      default = "/nix/var/nix/profiles/per-user/deploy-faktura/fakturamaskinen";
    };
  };

  config = mkIf cfg.enable {
    services.nginx.virtualHosts."faktura.magnusson.space" = {
      forceSSL = true;
      useACMEHost = "magnusson.space";

      locations."/" = {
        proxyPass = "http://localhost:${toString cfg.port}";
      };
    };

    systemd.services."faktura" = {
      description = "Fakturamaskinen";
      serviceConfig = {
        Type = "simple";
        Restart = "always";
        RestartSec = 10;
        ExecStart = "${cfg.package}/bin/fakturamaskinen -address localhost:${toString cfg.port}";
        WorkingDirectory = "/var/www/faktura";
        User = "faktura";
      };
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
    };

    users.users.faktura = {
      isSystemUser = true;
      group = "faktura";
    };
    users.groups.faktura = {};
    users.users.deploy-faktura = {
      isSystemUser = true;
      group = "deploy";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPO4K+TH/92mNXJ1w5yDO5wQSbhb2nj+wGvfXel/NjQT deploy-faktura@magnusson.space"
        # Private key at https://files.magnusson.space/.keys/deploy-faktura-key.age
      ];
      shell = pkgs.bashInteractive;
    };
  };
}
