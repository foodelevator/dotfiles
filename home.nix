{ config, pkgs, ... }:
let
  GOPATH = "$HOME/.local/share/go";
in
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

  home.sessionPath = [
    "${GOPATH}/bin"
  ];

  home.sessionVariables = {
    VISUAL = "nvim";
    EDITOR = "nvim";

    inherit GOPATH;
    CARGO_HOME = "$HOME/.local/share/cargo";
    RUSTUP_HOME = "$HOME/.local/share/rustup";

    XCOMPOSECACHE = "$HOME/.cache/compose-cache";
  };

  home.homeDirectory = "/home/mathias";
  home.username = "mathias";
  home.stateVersion = "22.11";
}
