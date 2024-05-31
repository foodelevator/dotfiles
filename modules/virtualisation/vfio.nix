{ config, lib, ... }:
let
  cfg = config.elevate.virtualisation.vfio;
in
{
  options.elevate.virtualisation.vfio = {
    enable = lib.mkEnableOption "Enable gpu passthrough with vfio";
  };

  config = (lib.mkIf cfg.enable {
    boot = {
      kernelParams = [
        "amd_iommu=on"
        "iommu=pt"
        "vfio-pci.ids=10de:1b83,10de:10f0"
        "rd.driver.pre=vfio-pci"
      ];
      initrd.kernelModules = [ "vfio_pci" "vfio_iommu_type1" "vfio" ];
      # RTX 3060: 10de:2489,10de:228b
      # GTX 1060: 10de:1b83,10de:10f0
    };
  });
}
