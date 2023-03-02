{ config, pkgs, ... }:
{
  imports = [
    ../../programs/discord
    ../../programs/alacritty

    ../../programs/nix
    # ../../programs/gdb
    ../../programs/lf
    ../../programs/nvim
  ];

  home.homeDirectory = "/home/mathias";
  home.username = "mathias";
  home.stateVersion = "22.11";
}
