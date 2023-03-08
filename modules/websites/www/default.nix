{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.websites.www;
  nginxCfg = config.elevate.services.nginx;
in
{
  options.elevate.websites.www = {
    enable = mkEnableOption "Static website for magnusson.space";
  };

  config = mkIf cfg.enable {
    services.nginx.virtualHosts."magnusson.space" =
      nginxCfg.virtualHostsDefaults // {
        default = true;
        serverAliases = [ "www.magnusson.space" ];

        root = "/var/www/www.magnusson.space";
        locations."/" = {
          index = "index.html";
        };
      };
  };
}
