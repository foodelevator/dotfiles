{ config, pkgs, ... }:
{
  xdg.configFile."discord/settings.json".source = ./settings.json;
}
