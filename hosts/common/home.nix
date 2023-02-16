{ config, pkgs, ... }:
let
  GOPATH = "$HOME/.local/share/go";
in
{
  imports = [
    ../../programs/rustup/home.nix

    ../../programs/discord
    ../../programs/alacritty

    ../../programs/nix
    # ../../programs/gdb
    ../../programs/lf
    ../../programs/nvim
    ../../programs/helix
  ];

  home.homeDirectory = "/home/mathias";
  home.username = "mathias";
  home.stateVersion = "22.11";
}
