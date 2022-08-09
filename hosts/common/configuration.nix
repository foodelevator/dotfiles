{ config, pkgs, ... }:
{
  environment.variables = {
    XCOMPOSECACHE = "$HOME/.cache/compose-cache";
  };
}
