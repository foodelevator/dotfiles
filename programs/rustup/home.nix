{ config, pkgs, ... }:
{
  xdg.dataFile."cargo/config.toml".source = ./cargo-config.toml;
}
