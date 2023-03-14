{ config, pkgs, lib, options, ... }:
with lib;
let
  cfg = config.elevate.services.nginx;
in
{
  options.elevate.services.nginx = {
    enable = mkEnableOption "http file server";
  };

  config = mkIf cfg.enable {
    services.nginx.enable = true;
    networking.firewall.allowedTCPPorts = [ 80 443 ];
  };
}
