{ config, pkgs, ... }:
{
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;

  networking.nameservers = [ "1.1.1.1" ];

  elevate.archetypes.workstation.enable = true;

  elevate.virtualisation.docker.enable = true;

  elevate.user = {
    enable = true;
    name = "mathias";
    email = "mathias@magnusson.space";
    description = "Mathias";
    groups = [ "networkmanager" "dialout" ];
  };
}
