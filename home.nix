{ config, pkgs, ... }:
{
  imports = [
    ./programs/cargo
    ./programs/dunst
    ./programs/fish
    # ./programs/gdb
    ./programs/git
    ./programs/i3
    ./programs/kitty
    ./programs/lf
    ./programs/nvim
  ];

  home.homeDirectory = "/home/mathias";
  home.username = "mathias";
  home.stateVersion = "22.11";
}
