{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.sets.programming;
in
{
  options.elevate.sets.programming = {
    enable = mkEnableOption "programs for programming programs and ports for development";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      lazygit
      pgcli

      zig
      gcc gnumake
      jdk java-language-server
      nil nixpkgs-fmt
    ];

    environment.variables = {
      LG_CONFIG_FILE = pkgs.writeText "lazygit.yaml" ''
        git:
          autoFetch: false
      '';
    };

    elevate.cli-apps.helix.enable = true;

    elevate.compilers = {
      encore.enable = true;
      go.enable = true;
      haskell.enable = true;
      julia.enable = true;
      node.enable = true;
      python.enable = true;
      rust.enable = true;
    };

    networking.firewall.allowedTCPPorts = [ 80 443 1337 3000 5000 8000 8080 ];
    networking.firewall.allowedUDPPorts = [ 1337 ];

    services.postgresql = {
      enable = true;
      package = pkgs.postgresql_15;
      enableJIT = true;
      ensureUsers = [{
        inherit (config.elevate.user) name;
        ensureClauses.superuser = true;
        ensureClauses.login = true;
      }];
    };
  };
}
