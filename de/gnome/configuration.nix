{ config, pkgs, ... }:
{
  services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment.systemPackages = with pkgs; [
    xwayland
    gnome.gnome-tweaks
  ] ++ (with pkgs.gnomeExtensions; [
    tray-icons-reloaded
    syncthing-icon
    gsconnect
  ]);
}
