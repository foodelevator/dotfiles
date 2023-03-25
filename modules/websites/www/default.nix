{ config, pkgs, lib, helpers, ... }:
with lib;
let
  cfg = config.elevate.websites.www;
in
{
  options.elevate.websites.www = {
    enable = mkEnableOption "Static website for magnusson.space";
  };

  config = mkIf cfg.enable {
    services.nginx.virtualHosts."magnusson.space" = {
      forceSSL = true;
      useACMEHost = "magnusson.space";

      default = true;
      serverAliases = [ "www.magnusson.space" ];

      root = "/var/www/www.magnusson.space";
      locations."/" = {
        index = "index.html";
      };
    };

    security.acme.certs."magnusson.space" = {
      extraDomainNames = [ "*.magnusson.space" ];
    };
  };
}
