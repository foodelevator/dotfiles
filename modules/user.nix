{ config, lib, ... }:
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
      default = [ ];
      description = "The groups the user should be a member of.";
    };
    description = mkOption {
      type = types.str;
      description = "The description of the user to create.";
    };
    sshKeys = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "SSH keys to be authorized.";
    };
    shell = mkOption {
      type = types.package;
      description = "The login shell";
    };
    home = mkOption {
      type = types.str;
      default = config.users.users.${cfg.name}.home;
    };
  };

  config = mkIf cfg.enable {
    users.users.${cfg.name} = {
      inherit (cfg) shell description;
      isNormalUser = true;
      extraGroups = [ "wheel" ] ++ cfg.groups;
      openssh.authorizedKeys.keys = cfg.sshKeys;
    };
  };
}
