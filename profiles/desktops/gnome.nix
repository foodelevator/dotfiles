{ pkgs, lib, ... }:
{
  services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
  services.gnome.gnome-keyring.enable = lib.mkForce false;

  environment.systemPackages = with pkgs; [
    xwayland
    gnome.gnome-tweaks
  ] ++ (with pkgs.gnomeExtensions; [
    tray-icons-reloaded
  ]);
}
