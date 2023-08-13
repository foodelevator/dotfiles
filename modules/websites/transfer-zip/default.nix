{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.websites.transfer-zip;
in
{
  options.elevate.websites.transfer-zip = {
    enable = mkEnableOption "Website for transfer.zip";
  };

  config = mkIf cfg.enable {
    services.nginx.virtualHosts.".transfer.zip" = {
      forceSSL = true;
      useACMEHost = "transfer.zip";

      locations."/" = {
        proxyPass = "http://localhost:9001";
        extraConfig = ''
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection $connection_upgrade;
          proxy_set_header Host $host;
        '';
      };
    };

    security.acme.certs."transfer.zip" = {
      extraDomainNames = [ "www.transfer.zip" ];
    };

    virtualisation.docker.enable = true;
  };
}
