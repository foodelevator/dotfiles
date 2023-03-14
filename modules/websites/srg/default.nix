{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.websites.srg;
in
{
  options.elevate.websites.srg = {
    enable = mkEnableOption "Särskilda kommandorörelsegruppen";
  };

  config = mkIf cfg.enable {
    services.nginx.virtualHosts."särskildakommandorörelsegruppen.se" = {
      forceSSL = true;
      useACMEHost = "xn--srskildakommandorrelsegruppen-0pc88c.se";
      serverName = "xn--srskildakommandorrelsegruppen-0pc88c.se";

      root = "/var/www/särskildakommandorörelsegruppen.se";
      locations."/" = {
        index = "index.html";
      };
    };
  };
}
