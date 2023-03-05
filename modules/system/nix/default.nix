{ config, pkgs, lib, inputs, ... }:
with lib;
let
  cfg = config.elevate.system.nix;
in
{
  options.elevate.system.nix = {
    enable = mkEnableOption "configure nix and nixpkgs";
  };

  config = mkIf cfg.enable {
    nix.registry.nixpkgs.flake = inputs.nixpkgs;

    nixpkgs.config.allowUnfree = true;

    nix.gc.automatic = true;
    nix.gc.options = "--delete-older-than 7d";
    nix.gc.dates = "weekly";
  };
}
