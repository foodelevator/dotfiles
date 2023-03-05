{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.sets.desktop;
in
{
  options.elevate.sets.desktop = {
    enable = mkEnableOption "desktop environment stuff and graphical applications";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      firefox ungoogled-chromium slack spotify obsidian zoom-us
      obs-studio qFlipper gimp
      (discord.override { nss = nss_latest; }) # override needed to open links
    ];

    elevate.apps.alacritty.enable = true;
    elevate.system.fonts.enable = true;
  };
}
