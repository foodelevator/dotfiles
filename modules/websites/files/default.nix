{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.websites.files;
  nginxCfg = config.elevate.services.nginx;
in
{
  options.elevate.websites.files = {
    enable = mkEnableOption "http file server";
  };

  config = mkIf cfg.enable {
    services.nginx.virtualHosts."files.magnusson.space" =
      nginxCfg.virtualHostsDefaults // {
        root = "/var/www/files.magnusson.space";
        extraConfig = ''
          autoindex on;
          location ~ /\. {
            autoindex off;
          }
        '';
      };
  };
}
