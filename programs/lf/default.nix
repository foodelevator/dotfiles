{ config, pkgs, ... }:
{
  xdg.configFile."lf/lfrc".source = ./lfrc;
}
