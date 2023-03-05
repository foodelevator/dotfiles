{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.compilers.encore;

  ENCORE_INSTALL = "$HOME/.local/share/encore";
in
{
  options.elevate.compilers.encore = {
    enable = mkEnableOption "encore configuration";
  };

  config = mkIf cfg.enable {
    environment.variables = {
      inherit ENCORE_INSTALL;
    };

    elevate.path = [ "${ENCORE_INSTALL}/bin" ];
  };
}
