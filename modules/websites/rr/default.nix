{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.websites.rr;
  nginxCfg = config.elevate.services.nginx;
in
{
  options.elevate.websites.rr = {
    enable = mkEnableOption "rr.magnusson.space";
  };

  config = mkIf cfg.enable {
    services.nginx.virtualHosts."rr.magnusson.space" =
      nginxCfg.virtualHostsDefaults // {
        root = "/var/www/rr.magnusson.space";
        locations."/" = {
          index = "index.mp4";
        };
      };
  };
}
