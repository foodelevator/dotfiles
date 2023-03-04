{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.security.yubikey;
in
{
  options.elevate.security.yubikey = {
    enable = mkEnableOption "yubikey for login and sudo and opt app";
  };

  config = mkIf cfg.enable {
    security.pam.services = {
      login.u2fAuth = true;
      sudo.u2fAuth = true;
    };

    services.pcscd.enable = true;

    environment.systemPackages = with pkgs; [
      yubioath-flutter
      pam_u2f
    ];
  };
}
