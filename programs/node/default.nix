{ config, pkgs, ... }:
{
  home.sessionVariables = {
    YARN_CACHE_FOLDER = "$HOME/.cache/yarn";
  };

  home.sessionPath = [
    "$HOME/.yarn/bin"
  ];

  home.packages = with pkgs; [
    yarn
    nodejs
  ];
}
