{ pkgs, ... }:
let
  prefix = "$HOME/.local/share/npm";
in
{
  environment.systemPackages = with pkgs; [ nodejs ];

  environment.variables = {
    npm_config_prefix = prefix;
    npm_config_cache = "$HOME/.cache/npm";
    NODE_REPL_HISTORY = "$HOME/.local/share/node/history";
    PATH = [ "${prefix}/bin" ];
  };
}
