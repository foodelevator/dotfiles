# https://nixos.org/manual/nixos/stable/index.html#module-security-acme
{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.security.tls-certificates;
in
{
  # TODO: make domain names configurable per server

  options.elevate.security.tls-certificates = {
    enable = mkEnableOption "Automatically get TLS certificates";
  };

  config = mkIf cfg.enable {
    security.acme.acceptTerms = true;
    security.acme.defaults = {
      dnsProvider = "linode";
      email = "mathias@magnusson.space";
      credentialsFile = "/var/lib/secrets/linode-dns-api-key.ini";
    };

    security.acme.certs = {
      "magnusson.space" = {
        extraDomainNames = [ "*.magnusson.space" ];
      };
    };

    users.users.nginx.extraGroups = [ "acme" ];
  };
}
