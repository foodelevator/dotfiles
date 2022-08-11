{ config, pkgs, ... }:
{
  xdg.configFile."discord/settings.json".source = ./settings.json;

  home.packages = with pkgs; [
    (discord.override { nss = nss_latest; }) # needed to open links
  ];
}
