{ config, pkgs, lib, helpers, ... }:
with lib;
let
  cfg = config.elevate.websites.keys;
in
{
  options.elevate.websites.keys = {
    enable = mkEnableOption "Link";
  };

  config = mkIf cfg.enable {
    services.nginx.virtualHosts."keys.magnusson.space" = {
      addSSL = true;
      enableACME = true;

      root = pkgs.writeTextFile {
        name = "ssh key file";
        destination = "/index.txt";
        text = ''
          ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEdUe7mxGdV/Q37RKndPzDHisFb7q/xm+L97jcGluSDOA8MGt/+wTxpyGxfyEqaMvwV2bakaMVHTB3711dDu5kE=
        '';
      };

      locations."/" = {
        index = "index.txt";
      };
    };
  };
}
