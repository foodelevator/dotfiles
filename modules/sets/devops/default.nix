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
      hcloud
      nomad
    ];

    environment.variables = {
      TF_CLI_CONFIG_FILE = pkgs.writeText "terraform.tfrc" ''
        disable_checkpoint = true
      '';
    };
  };
}
