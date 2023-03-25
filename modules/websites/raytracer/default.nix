{ config, pkgs, lib, helpers, ... }:
with lib;
let
  cfg = config.elevate.websites.raytracer;
in
{
  options.elevate.websites.raytracer = {
    enable = mkEnableOption "Raytracer website";
  };

  config = mkIf cfg.enable {
    services.nginx.virtualHosts."raytracer.magnusson.space" = {
      forceSSL = true;
      useACMEHost = "magnusson.space";

      root = "/var/www/raytracer.magnusson.space";
      locations."/" = {
        index = "index.html";
      };
    };
  };
}
