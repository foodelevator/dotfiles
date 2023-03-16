{ config, pkgs, lib, inputs, helpers, ... }:
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
      # default = inputs.fakturamaskinen.packages.${pkgs.system}.fakturamaskinen;
      default = "/nix/var/nix/profiles/per-user/mathias/fakturamaskinen";
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

    systemd.services."faktura.magnusson.space" = {
      description = "Fakturamaskinen";
      serviceConfig = {
        Type = "simple";
        Restart = "always";
        RestartSec = 10;
        ExecStart = "${cfg.package}/bin/fakturamaskinen -address localhost:${toString cfg.port}";
        WorkingDirectory = "/var/www/faktura.magnusson.space";
      };
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
    };
  };
}
