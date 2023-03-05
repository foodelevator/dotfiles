{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.sets.programming;
in
{
  options.elevate.sets.programming = {
    enable = mkEnableOption "programs for programming programs";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      lazygit
      pgcli

      zig
      gcc gnumake
      jdk java-language-server
      swiProlog
      rnix-lsp
    ];

    elevate.cli-apps.helix.enable = true;

    elevate.compilers = {
      encore.enable = true;
      go.enable = true;
      haskell.enable = true;
      node.enable = true;
      python.enable = true;
      rust.enable = true;
    };
  };
}
