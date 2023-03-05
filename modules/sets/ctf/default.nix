{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.sets.ctf;
in
{
  options.elevate.sets.ctf = {
    enable = mkEnableOption "engage hacker mode";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      ghidra binary-ninja
    ];
  };
}
