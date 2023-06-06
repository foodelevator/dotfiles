{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.security.yubikey;

  dir = "$HOME/.local/share/passage";
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

    services.yubikey-agent.enable = true;

    environment.systemPackages = with pkgs; [
      pam_u2f
      yubikey-manager
      yubioath-flutter

      age
      age-plugin-yubikey

      passage
    ];

    environment.variables = {
      PASSAGE_DIR = "${dir}/store";
      PASSAGE_IDENTITIES_FILE = "${dir}/identities";
      PASSAGE_EXTENSIONS_DIR = "${dir}/extensions";
    };
  };
}
