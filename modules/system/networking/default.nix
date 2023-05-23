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

    # networking.hosts = {
    #   "127.0.0.1" = [ "login.datasektionen.se" ];
    # };

    networking.networkmanager.enable = true;

    elevate.user.groups = [ "networkmanager" ];
  };
}
