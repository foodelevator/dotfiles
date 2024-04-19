{ config, lib, ... }:
with lib;
let
  cfg = config.elevate.services.wireguard;
in
{
  options.elevate.services.wireguard = {
    enableServer = mkEnableOption "wireguard server";
    enableClient = mkEnableOption "wireguard client";
  };

  config = mkMerge [
    (mkIf cfg.enableServer {
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
    })
    (mkIf cfg.enableClient {
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
    })
  ];
}
