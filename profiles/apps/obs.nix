{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    obs-studio
  ];

  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
}
