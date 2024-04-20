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
      firefox ungoogled-chromium
      spotify
      slack zulip mattermost-desktop signal-desktop zoom-us
      obsidian gimp audacity
      (discord.override { nss = nss_latest; }) # override needed to open links

      mpv feh
    ];

    programs.evince.enable = true;
    programs.nix-ld.enable = true;

    elevate.apps.kitty.enable = true;
    elevate.system.fonts.enable = true;

    elevate.services.tldcheck = {
      enable = true;
      tlds = [ "on" "son" "sson" ];
    };

    services.xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "altgr-intl";
      xkbOptions = "caps:escape";

      libinput = {
        enable = true;
        mouse = {
          accelProfile = "flat";
        };
        touchpad = {
          naturalScrolling = true;
          clickMethod = "clickfinger";
        };
      };

      excludePackages = [ pkgs.xterm ]; # 'tis ugly af
    };
  };
}
