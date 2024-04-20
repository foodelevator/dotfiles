{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.system.networking;
in
{
  options.elevate.system.networking = {
    enable = mkEnableOption "configure networking";
  };

  config = mkIf cfg.enable {
    networking.nameservers = [ "1.1.1.1" ];

    boot.kernel.sysctl = {
      "net.ipv4.ip_unprivileged_port_start" = 0;
    };

    networking.hosts = {
      # "52.213.59.75" = [ "pax.datasektionen.se" ];
    };

    networking.networkmanager.enable = true;

    elevate.user.groups = [ "networkmanager" ];
  };
}
