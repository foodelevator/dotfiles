{ config, pkgs, ... }:
{
  xdg.dataFile."cargo/config.toml".source = ./config.toml;
}
