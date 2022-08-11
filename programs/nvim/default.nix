{ config, pkgs, ... }:
{
  xdg.configFile."nvim".source = ./.;

  home.packages = with pkgs; [
    tree-sitter
    ripgrep
    fd
  ];
}
