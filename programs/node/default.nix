{ config, pkgs, ... }:
{
  home.shellAliases = {
    npmg = "npm --prefix=\"$HOME/.local/share/npm\"";
  };

  home.packages = with pkgs; [
    nodejs
  ];
}
