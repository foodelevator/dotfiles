{ config, pkgs, lib, inputs, ... }:
with lib;
let
  cfg = config.elevate.websites.dinlugnastund;
in
{
  options.elevate.websites.dinlugnastund = {
    enable = mkEnableOption "Website for dinlugnastund.se";
    port = mkOption {
      type = types.port;
      default = 7001;
    };
    package = mkOption {
      type = with types; either package str;
      default = "/nix/var/nix/profiles/per-user/deploy-dinlugnastund/dinlugnastund";
    };
  };

  config = mkIf cfg.enable {
    services.nginx.virtualHosts.".dinlugnastund.se" = {
      forceSSL = true;
      useACMEHost = "dinlugnastund.se";

      locations."/" = {
        proxyPass = "http://localhost:${toString cfg.port}";
      };
    };

    systemd.services."dinlugnastund" = {
      description = "dinlugnastund";
      serviceConfig = {
        Type = "simple";
        Restart = "always";
        RestartSec = 10;
        Environment = "PORT=${toString cfg.port}";
        ExecStart = "${cfg.package}/bin/dinlugnastund";
        WorkingDirectory = "/tmp";
        User = "dinlugnastund";
      };
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
    };

    elevate.deploy-user.dinlugnastund = { };

    security.acme.certs."dinlugnastund.se" = {
      extraDomainNames = [ "www.dinlugnastund.se" ];
    };
  };
}
