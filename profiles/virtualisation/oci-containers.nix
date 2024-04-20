{ pkgs, ... }:
{
  virtualisation.podman.enable = true;
  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
