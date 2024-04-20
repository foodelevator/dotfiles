{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.compilers.julia;
in
{
  options.elevate.compilers.julia = {
    enable = mkEnableOption "Julia programming language";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ julia-bin ];

    environment.variables = {
      JULIA_DEPOT_PATH = [ "$HOME/.local/share/julia" ];
    };
  };
}
