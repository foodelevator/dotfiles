{ ... }:
{
  networking.firewall.allowedUDPPorts = [ 51820 ];
  networking.wg-quick.interfaces.wg0 = {
    address = [ "10.69.0.1/24" ];
    listenPort = 51820;
    privateKeyFile = "/home/mathias/.local/share/wg-keys/privatekey";
    peers = [
      {
        publicKey = "FqwkR+gKe/0JfFn3oXyyNDK8qh3LGMQw/t1pvGEHTBk=";
        allowedIPs = [ "10.69.0.2/32" ];
      }
    ];
  };
}
