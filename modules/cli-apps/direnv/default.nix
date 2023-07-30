{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.cli-apps.direnv;
in
{
  options.elevate.cli-apps.direnv = {
    enable = mkEnableOption "configured command line for the 90s";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ direnv nix-direnv ];

    nix.settings = {
      keep-outputs = true;
      keep-derivations = true;
    };

    environment.pathsToLink = [
      "/share/nix-direnv"
    ];
  };
}
