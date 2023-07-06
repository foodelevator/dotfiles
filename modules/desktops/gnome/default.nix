{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.desktops.gnome;
in
{
  options.elevate.desktops.gnome = {
    enable = mkEnableOption "GANOME";
  };

  config = mkIf cfg.enable {
    services.xserver = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    services.gnome.gnome-keyring.enable = mkForce false;

    environment.systemPackages = with pkgs; [
      xwayland
      gnome.gnome-tweaks
    ] ++ (with pkgs.gnomeExtensions; [
      tray-icons-reloaded
      syncthing-icon
    ]);

    networking.firewall.allowedTCPPortRanges = [ { from = 1716; to = 1764; } ];
  };
}
