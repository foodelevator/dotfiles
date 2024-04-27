{ profiles, ... }:
{
  imports = with profiles; [
    system.networking
    sets.base
    services.sshd
    services.wireguard
  ];
}
