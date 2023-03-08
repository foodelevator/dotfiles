{ config, pkgs, lib, options, ... }:
with lib;
let
  cfg = config.elevate.services.nginx;
in
{
  options.elevate.services.nginx = {
    enable = mkEnableOption "http file server";
    virtualHostsDefaults = mkOption {
      type = options.services.nginx.virtualHosts.type.nestedTypes.elemType;
      default = {
        forceSSL = true;
        useACMEHost = "magnusson.space";
      };
    };
  };

  config = mkIf cfg.enable {
    services.nginx.enable = true;
    networking.firewall.allowedTCPPorts = [ 80 443 ];
  };
}
