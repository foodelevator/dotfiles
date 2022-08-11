{ config, pkgs, ... }:
{
  xdg.configFile."lf/lfrc".source = ./lfrc;

  home.packages = [ pkgs.lf ];
}
