{ config, pkgs, ... }:
{
  imports = [
    ../../programs/discord

    ../../programs/nix
    # ../../programs/gdb
    ../../programs/nvim
  ];

  home.homeDirectory = "/home/mathias";
  home.username = "mathias";
  home.stateVersion = "22.11";
}
