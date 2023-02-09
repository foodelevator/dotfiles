{ config, pkgs, ... }:
{
  programs.kdeconnect.enable = true;

  services.logind.extraConfig = ''
    HandlePowerKey=hibernate
  '';

  services.xserver = {
    displayManager.lightdm.enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
  };
}
