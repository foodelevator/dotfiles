{ config, pkgs, ... }:
{
  xdg.configFile."awesome/rc.lua".source = ./rc.lua;
}
