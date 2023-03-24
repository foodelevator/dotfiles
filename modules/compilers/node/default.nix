{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.compilers.node;

  prefix = "$HOME/.local/share/npm";
in
{
  options.elevate.compilers.node = {
    enable = mkEnableOption "configured nodejs interpreter";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ nodejs ];

    environment.variables = {
      npm_config_prefix = prefix;
      npm_config_cache = "$HOME/.cache/npm";
      NODE_REPL_HISTORY = "$HOME/.local/share/node/history";
      PATH = [ "${prefix}/bin" ];
    };
  };
}
