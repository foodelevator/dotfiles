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

  users.users.mathias.packages = with pkgs; [
    # Terminal
    scrot brightnessctl htop feh

    # Graphical
    pavucontrol arandr mpv

    # WM-related
    dunst i3blocks i3lock-fancy
  ];
}
