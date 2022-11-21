{ config, pkgs, ... }:
{
  home.sessionVariables = {
    npm_config_prefix = "\${HOME}/.local/share/npm";
    npm_config_cache="\${HOME}/.cache/npm";
  };

  home.sessionPath = [
    "$HOME/.local/share/npm/bin"
  ];

  home.packages = with pkgs; [
    nodejs
  ];
}
