{ pkgs, config, ... }:
{
  programs.ssh.startAgent = true;

  programs.ssh.extraConfig = builtins.readFile ./config;
}
