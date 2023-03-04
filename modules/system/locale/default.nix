{ config, lib, ... }:
with lib;
let
  cfg = config.elevate.system.locale;
in
{
  options.elevate.system.locale = {
    enable = mkEnableOption "setup locale";
  };

  config = mkIf cfg.enable {
    i18n.defaultLocale = "en_US.utf8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "sv_SE.utf8";
      LC_IDENTIFICATION = "sv_SE.utf8";
      LC_MEASUREMENT = "sv_SE.utf8";
      LC_MONETARY = "sv_SE.utf8";
      LC_NAME = "sv_SE.utf8";
      LC_NUMERIC = "sv_SE.utf8";
      LC_PAPER = "sv_SE.utf8";
      LC_TELEPHONE = "sv_SE.utf8";
      LC_TIME = "sv_SE.utf8";
    };
  };
}
