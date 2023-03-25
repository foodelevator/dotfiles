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
    # TODO: make this little service work like a good little service
    # services.yubikey-agent.enable = true;

    environment.systemPackages = with pkgs; [
      pam_u2f
      yubikey-manager
      yubioath-flutter

      age
      age-plugin-yubikey
    ];
  };
}
