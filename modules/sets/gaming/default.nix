{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.sets.gaming;
in
{
  options.elevate.sets.gaming = {
    enable = mkEnableOption "programs and configuration for gaming";
  };

  config = mkIf cfg.enable {
    elevate.apps.steam.enable = true;
    environment.systemPackages = with pkgs; [ prismlauncher ];
  };
}
