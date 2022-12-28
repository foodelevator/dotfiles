{ config, pkgs, ... }:
{
  imports = [
    ../common/home.nix
    # ../../de/i3/home.nix
    # ../../de/kde/home.nix
    ../../de/gnome/home.nix
  ];

  home.packages = with pkgs; [
    vscode
  ];
}
