{ config, pkgs, lib, inputs, ... }:
with lib;
let
  cfg = config.elevate.cli-apps.typst;
in
{
  options.elevate.cli-apps.typst = {
    enable = mkEnableOption "typst - typesetting hipster or something";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      typst typst-lsp
    ];
  };
}
