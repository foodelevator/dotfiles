{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.websites.srg;
  nginxCfg = config.elevate.services.nginx;
in
{
  options.elevate.websites.srg = {
    enable = mkEnableOption "Särskilda kommandorörelsegruppen";
  };

  config = mkIf cfg.enable {
    services.nginx.virtualHosts."särskildakommandorörelsegruppen.se" =
      nginxCfg.virtualHostsDefaults // {
        useACMEHost = "xn--srskildakommandorrelsegruppen-0pc88c.se";
        serverName = "xn--srskildakommandorrelsegruppen-0pc88c.se";
        root = "/var/www/särskildakommandorörelsegruppen.se";
        locations."/" = {
          index = "index.html";
        };
      };
  };
}
