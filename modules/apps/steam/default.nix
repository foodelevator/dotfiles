{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.apps.steam;
in
{
  options.elevate.apps.steam = {
    enable = mkEnableOption "valve steam";
  };

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };
}
