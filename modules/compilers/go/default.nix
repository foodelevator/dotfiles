{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.compilers.go;

  GOPATH = "$HOME/.local/share/go";
in
{
  options.elevate.compilers.go = {
    enable = mkEnableOption "configured go environment";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ go gopls ];

    environment.variables = {
      inherit GOPATH;
    };

    elevate.path = [ "${GOPATH}/bin" ];
  };
}
