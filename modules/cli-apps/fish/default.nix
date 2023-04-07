{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.cli-apps.fish;
in
{
  options.elevate.cli-apps.fish = {
    enable = mkEnableOption "configured command line for the 90s";
  };

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;

      shellInit = builtins.readFile ./config.fish;
    };

    environment.systemPackages = [ pkgs.direnv ];

    elevate.user.shell = pkgs.fish;
  };
}
