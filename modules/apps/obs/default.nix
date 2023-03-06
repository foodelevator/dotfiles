{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.apps.obs;
in
{
  options.elevate.apps.obs = {
    enable = mkEnableOption "configure obs studio";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      obs-studio
    ];

    boot.extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
  };
}
