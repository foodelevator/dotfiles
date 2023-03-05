{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.system.printing;
in
{
  options.elevate.system.printing = {
    enable = mkEnableOption "🖨️ go brrrrrrr...";
  };

  config = mkIf cfg.enable {
    services.printing.enable = true;
    services.printing.drivers = [ pkgs.hplip ];
  };
}
