# TODO: look into using services.hardware.openrgb
{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.apps.openrgb;
in
{
  options.elevate.apps.openrgb = {
    enable = mkEnableOption "öppna färger";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.openrgb ];
    hardware.i2c.enable = true;
    services.udev.extraRules = (builtins.readFile ./60-openrgb.rules);
  };
}
