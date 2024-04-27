{ pkgs, profiles, ... }:
{
  imports = with profiles; [
    system.networking
    sets.base
    services.sshd
    services.wireguard
  ];

  environment.systemPackages = with pkgs; [
    htop
  ];

  environment.enableAllTerminfo = true;
}
