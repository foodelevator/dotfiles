{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.user;
in
{
  options.elevate.user = {
    enable = mkEnableOption "create a user";
    name = mkOption {
      type = types.passwdEntry types.str;
      description = "The name of the user to create.";
    };
    email = mkOption {
      type = types.str;
      description = "The email address of the user to create.";
    };
    groups = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "The groups the user should be a member of.";
    };
    description = mkOption {
      type = types.str;
      description = "The description of the user to create.";
    };
  };

  config = mkIf cfg.enable {
    users.users.${cfg.name} = {
      isNormalUser = true;
      extraGroups = [ "wheel" ] ++ cfg.groups;
      shell = pkgs.fish;
      description = cfg.description;
    };
  };
}
