{ config, pkgs, ... }:
let
  GOPATH = "$HOME/.local/share/go";
in
{
  imports = [
    ../../programs/git
    ../../programs/rustup
    ../../programs/node

    ../../programs/discord
    ../../programs/dunst
    ../../programs/i3
    ../../programs/alacritty

    ../../programs/fish
    # ../../programs/gdb
    ../../programs/lf
    ../../programs/nvim
  ];

  home.sessionPath = [
    "${GOPATH}/bin"
  ];

  home.sessionVariables = {
    VISUAL = "nvim";
    EDITOR = "nvim";

    inherit GOPATH;
  };

  home.homeDirectory = "/home/mathias";
  home.username = "mathias";
  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    feh
    xclip
    scrot
    killall

    zig
    go

    firefox
    slack
    spotify
    pavucontrol
  ];
}
