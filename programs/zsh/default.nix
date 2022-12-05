{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;

    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    autocd = true;

    dotDir = ".config/zsh";
  };

  environment.pathsToLink = [ "/share/zsh" ];
}
