{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.openrgb ];
  hardware.i2c.enable = true;
  services.udev.extraRules = (builtins.readFile ./60-openrgb.rules);
}
