{ config, pkgs, ... }:
{
  imports = [
    ../../programs/dunst
    ../../programs/i3
  ];

  home.packages = with pkgs; [
    pavucontrol
    scrot
    mpv
    arandr
    brightnessctl
  ];
}
