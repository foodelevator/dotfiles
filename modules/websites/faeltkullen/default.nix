{ config, pkgs, lib, helpers, ... }:
with lib;
let
  cfg = config.elevate.websites.faeltkullen;
in
{
  options.elevate.websites.faeltkullen = {
    enable = mkEnableOption "Web version of fältkullen";
  };

  config = mkIf cfg.enable {
    services.nginx.virtualHosts."fältkullen.magnusson.space" = {
      forceSSL = true;
      useACMEHost = "magnusson.space";
      serverName = "xn--fltkullen-v2a.magnusson.space";

      root = "/var/www/fältkullen.magnusson.space";
      locations."/" = {
        index = "index.html";
      };
    };
  };
}
