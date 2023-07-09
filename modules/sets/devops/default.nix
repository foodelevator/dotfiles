{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.sets.devops;
in
{
  options.elevate.sets.devops = {
    enable = mkEnableOption "opping the devs";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      terraform
      terraform-ls
      awscli2
      nomad
    ];
  };
}
