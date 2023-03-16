{ config, pkgs, lib, inputs, helpers, ... }:
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
      default = "/nix/var/nix/profiles/per-user/mathias/dinlugnastund";
    };
  };

  config = mkIf cfg.enable {
    services.nginx.virtualHosts."new.dinlugnastund.se" = {
      forceSSL = true;
      enableACME = true;

      locations."/" = {
        proxyPass = "http://localhost:${toString cfg.port}";
      };
    };

    systemd.services."dinlugnastund.se" = {
      description = "dinlugnastund.se";
      serviceConfig = {
        Type = "simple";
        Restart = "always";
        RestartSec = 10;
        Environment = "PORT=${toString cfg.port}";
        ExecStart = "${cfg.package}/bin/dinlugnastund";
        WorkingDirectory = "/var/www/dinlugnastund.se";
      };
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
    };
  };
}
