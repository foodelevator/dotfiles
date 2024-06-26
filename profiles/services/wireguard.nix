{ config, lib, ... }:
let
  nodes = {
    ymer = {
      publicKey = "LEQ8lB86aK6tfKE2ppsz7raYs69Y1kZsc8O1hnatIms=";
      privateAddr = "10.69.0.1";
      address = { host = "home.magnusson.space"; port = 51800; };
    };
    sleipner = {
      publicKey = "FqwkR+gKe/0JfFn3oXyyNDK8qh3LGMQw/t1pvGEHTBk=";
      privateAddr = "10.69.0.2";
    };
    mimer = {
      publicKey = "mhGuL7fW63TnXHXNTTmT0Ij3hdEGMRCruxW5jbC5rC8=";
      privateAddr = "10.69.0.3";
      address = { host = "home.magnusson.space"; port = 51801; };
    };
    lucas = {
      publicKey = "Kzu4B/NoTD9o7ZnmPC/blwOEkxRZaxtjD1WYadJA9EE=";
      privateAddr = "10.69.1.1";
    };
  };

  thisNode = nodes.${config.networking.hostName};
  peers = builtins.attrValues (removeAttrs nodes [ config.networking.hostName ]);
in
{
  networking.firewall.allowedUDPPorts = lib.mkIf (thisNode ? address) [ thisNode.address.port ];
  networking.wg-quick.interfaces.wg0 = {
    address = [ "${thisNode.privateAddr}/16" ];
    listenPort = lib.mkIf (thisNode ? address) thisNode.address.port;
    privateKeyFile = config.elevate.user.home + "/.local/share/wg-keys/privatekey";
    peers = lib.forEach peers (peer: {
      inherit (peer) publicKey;
      allowedIPs = [ "${peer.privateAddr}/32" ];
    } // lib.optionalAttrs (peer ? address) {
      endpoint = "${peer.address.host}:${toString peer.address.port}";
    });
  };
}
