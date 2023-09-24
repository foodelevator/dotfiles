{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.desktops.i3;
in
{
  options.elevate.desktops.i3 = {
    enable = mkEnableOption "i3wm";
  };

  config = mkIf cfg.enable {
    services.xserver = {
      displayManager.lightdm.enable = true;
      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
        configFile = pkgs.substituteAll { src = ./config; i3blocks = ./i3blocks; };
      };
    };

    environment.systemPackages = with pkgs; [
      # Terminal
      scrot htop

      # Graphical
      pavucontrol

      # WM-related
      dunst i3blocks
    ];

    programs.kdeconnect.enable = true;
    programs.gnupg.agent.pinentryFlavor = "qt";
  };
}
