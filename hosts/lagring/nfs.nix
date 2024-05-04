{ ... }:
{
  fileSystems."/export" = {
    device = "/media/nvme";
    options = [ "bind" ];
  };

  services.nfs.server = {
    enable = true;
    statdPort = 4000;
    lockdPort = 4001;
    mountdPort = 4002;
    exports = ''
      /export/mathias -rw,sync,insecure 10.69.0.0/16 192.168.1.2
      /export/lucas 192.168.1.6(rw,sync,insecure,all_squash)
    '';
  };

  systemd.tmpfiles.rules = [
    "d /media/nvme/mathias 0755 mathias users -"
    "d /media/nvme/lucas 0755 nobody nogroup -"
  ];

  networking.firewall.allowedTCPPorts = [ 111 4000 4001 4002 2049 ];
  networking.firewall.allowedUDPPorts = [ 111 4000 4001 4002 ];
}
