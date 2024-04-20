{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.deploy-user;
in
{
  options.elevate.deploy-user = mkOption {
    default = { };
    type = with types; attrsOf (submodule ({ config, lib, ... }: {
      options = {
        keys = mkOption {
          default = [ ];
          type = listOf str;
          description = "List of ssh keys allowed to deploy this service";
        };
      };
    }));
  };

  config = mkIf (cfg != { }) {
    security.sudo.extraRules = [{
      groups = [ "deploy" ];
      commands = [
        { command = "/run/current-system/sw/bin/systemctl restart *"; options = [ "NOPASSWD" ]; }
      ];
    }];
    nix.settings.trusted-users = [ "@deploy" ];

    users.users = with pkgs.lib; builtins.listToAttrs (
      (mapAttrsToList (name: _: {
        inherit name;
        value = {
          isSystemUser = true;
          group = name;
        };
      }) cfg) ++
      (mapAttrsToList (name: value: {
        name = "deploy-${name}";
        value = {
          isSystemUser = true;
          group = "deploy";
          openssh.authorizedKeys.keys = value.keys;
          shell = pkgs.bashInteractive;
        };
      }) cfg)
    );
    users.groups = { deploy = { }; } // builtins.mapAttrs (_: _: { }) cfg;
  };
}
