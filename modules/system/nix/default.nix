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
    nix.registry.unstable.flake = inputs.unstable;
    nix.nixPath = [
      "nixpkgs=${inputs.nixpkgs}"
      "unstable=${inputs.unstable}"
    ];

    nix.settings.trusted-users = [ config.elevate.user.name ];

    nix.gc.automatic = true;
    nix.gc.options = "--delete-older-than 7d";
    nix.gc.dates = "weekly";

    nix.package = pkgs.nixFlakes;
    nix.extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
