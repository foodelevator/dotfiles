{ config, pkgs, ... }:
{
  programs.adb.enable = true;
  users.users.mathias.extraGroups = ["adbusers"];
}
