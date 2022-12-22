{ config, pkgs, ... }:
{
  imports = [
    ../common/home.nix

    ../../de/i3/home.nix
  ];

  home.packages = with pkgs; [
    openrgb
  ];
}
