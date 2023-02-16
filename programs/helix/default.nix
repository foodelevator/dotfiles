{ config, pkgs, ... }:
{
  xdg.configFile."helix/config.toml".source = ./config.toml;
}
