{ config, pkgs, ... }:
{
  services.udev.extraRules = (builtins.readFile ./60-openrgb.rules);
}
