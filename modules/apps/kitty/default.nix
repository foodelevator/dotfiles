{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.apps.kitty;

  kitty = pkgs.runCommand "kitty" {
    buildInputs = [ pkgs.makeWrapper ];
  } ''
    mkdir -p $out/bin
    makeWrapper ${pkgs.kitty}/bin/kitty $out/bin/kitty \
      --add-flags "-c ${./config}/kitty.conf"
  '';
in
{
  options.elevate.apps.kitty = {
    enable = mkEnableOption "configured kitty terminal emulator";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ kitty ];
  };
}
