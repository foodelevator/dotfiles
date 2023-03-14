{ config, pkgs, lib, helpers, ... }:
with lib;
let
  cfg = config.elevate.websites.rr;
in
{
  options.elevate.websites.rr = {
    enable = mkEnableOption "rr.magnusson.space";
  };

  config = mkIf cfg.enable {
    services.nginx.virtualHosts."rr.magnusson.space" = {
      forceSSL = true;
      useACMEHost = "magnusson.space";

      root = "/var/www/rr.magnusson.space";
      locations."/" = {
        index = "index.mp4";
      };
    };

    security.acme.certs = helpers.mkWildcardCert "magnusson.space";
  };
}
