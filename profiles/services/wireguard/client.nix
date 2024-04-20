{ ... }:
{
  networking.wg-quick.interfaces.wg0 = {
    address = [ "10.69.0.2/24" ];
    privateKeyFile = "/home/mathias/.local/share/wg-keys/privatekey";

    peers = [
      {
        publicKey = "LEQ8lB86aK6tfKE2ppsz7raYs69Y1kZsc8O1hnatIms=";
        allowedIPs = [ "10.69.0.1/32" ];
        endpoint = "home.magnusson.space:51820";
      }
    ];
  };
}
