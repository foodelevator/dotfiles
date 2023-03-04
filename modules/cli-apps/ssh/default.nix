{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.cli-apps.ssh;
in
{
  options.elevate.cli-apps.ssh = {
    enable = mkEnableOption "configured ssh";
  };

  config = mkIf cfg.enable {
    programs.ssh.startAgent = true;

    programs.ssh.extraConfig = builtins.readFile ./config;
  };
}
