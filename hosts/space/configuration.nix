{ config, pkgs, ... }:
{
  elevate.websites.dinlugnastund.enable = true;

  elevate.websites.faktura.enable = true;
  elevate.websites.files.enable = true;
  elevate.websites.raytracer.enable = true;
  elevate.websites.rr.enable = true;
  elevate.websites.srg.enable = true;
  elevate.websites.www.enable = true;
  elevate.websites.faeltkullen.enable = true;
  elevate.websites.keys.enable = true;
  elevate.websites.transfer-zip.enable = true;

  elevate.archetypes.server.enable = true;

  security.acme.certs."magnusson.space" = {
    dnsProvider = "linode";
    credentialsFile = "/var/lib/secrets/linode-dns-api-key.ini";
    webroot = null;

    extraDomainNames = [ "*.magnusson.space" "magnusson.wiki" "*.magnusson.wiki" ];
  };

  networking.firewall.allowedTCPPorts = [ 1337 ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";

  networking.usePredictableInterfaceNames = false;

  environment.systemPackages = with pkgs; [
    inetutils
    mtr
    sysstat
  ];

  # Linode longview
  services.longview = {
    enable = true;
    apiKeyFile = "/var/lib/secrets/longview";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}

