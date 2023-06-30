{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.virtualisation.oci-containers;
in
{
  options.elevate.virtualisation.oci-containers = {
    enable = mkEnableOption "OCI Containers";
  };

  config = mkIf cfg.enable {
    virtualisation.podman.enable = true;

    # Using podman as a docker daemon does not seem to work with nomad
    virtualisation.docker.enable = true;
  };
}
