{ config, pkgs, ... }:
{
  imports = [
    ../../programs/discord/home.nix
    ../../programs/nix/home.nix
    ../../programs/nvim/home.nix
  ];

  home.homeDirectory = "/home/mathias";
  home.username = "mathias";
  home.stateVersion = "22.11";
}
