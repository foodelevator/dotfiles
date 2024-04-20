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

    nix.package = pkgs.nixFlakes;
    nix.extraOptions = ''
      experimental-features = nix-command flakes

      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
    '';

    # programs.nh = {
    #   enable = true;
    #   flake = "${config.users.users.${config.elevate.user.name}.home}/dotfiles";
    # };
  };
}
