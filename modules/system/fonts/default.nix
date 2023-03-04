{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.system.fonts;
in
{
  options.elevate.system.fonts = {
    enable = mkEnableOption "install fonts";
  };

  config = mkIf cfg.enable {
    fonts.fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];
  };
}
