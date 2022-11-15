{ config, pkgs, ... }:
{
  xdg.configFile."helix/config.toml".source = ./config.toml;

  home.packages = with pkgs; [
    helix
  ];
}
