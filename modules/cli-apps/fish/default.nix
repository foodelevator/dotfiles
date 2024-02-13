{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.cli-apps.fish;

  wrapper = pkgs.writeScript "command-not-found" ''
    #!${pkgs.bash}/bin/bash
    source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
    command_not_found_handle "$@"
  '';

  notFoundHandler = ''
    function __fish_command_not_found_handler --on-event fish_command_not_found
      ${wrapper} $argv
    end
  '';
in
{
  options.elevate.cli-apps.fish = {
    enable = mkEnableOption "configured command line for the 90s";
  };

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;

      shellInit = (builtins.readFile ./config.fish) + notFoundHandler;
    };

    programs.thefuck.enable = true;
    programs.command-not-found.enable = false;

    elevate.user.shell = pkgs.fish;
  };
}
