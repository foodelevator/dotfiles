{ ... }:
{
  networking.nameservers = [ "1.1.1.1" ];

  boot.kernel.sysctl = {
    "net.ipv4.ip_unprivileged_port_start" = 0;
  };

  networking.networkmanager.enable = true;

  elevate.user.groups = [ "networkmanager" ];
}
