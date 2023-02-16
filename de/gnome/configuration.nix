{ config, pkgs, ... }:
{
  services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  users.users.mathias.packages = with pkgs; [
    xwayland
    gnome.gnome-tweaks
  ] ++ (with pkgs.gnomeExtensions; [
    tray-icons-reloaded
    syncthing-icon
    gsconnect
  ]);
}
