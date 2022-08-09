{ config, pkgs, ... }:
{
  imports = [
    ../common/home.nix
    ../../programs/node
  ];

  home.packages = with pkgs; [];
}
