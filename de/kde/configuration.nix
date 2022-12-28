{ config, pkgs, ... }:
{
  services.xserver = {
    displayManager.lightdm.enable = true;
    desktopManager.plasma5.enable = true;
  };
}
