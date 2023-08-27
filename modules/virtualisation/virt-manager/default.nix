{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.virtualisation.virt-manager;
in
{
  options.elevate.virtualisation.virt-manager = {
    enable = mkEnableOption "virt-manager & libvirtd";
    gpu-passthrough = mkEnableOption "GPU passthrough";
  };

  config = mkMerge [
    (mkIf cfg.enable {
      virtualisation.libvirtd.enable = true;
      virtualisation.libvirtd.qemu.package = pkgs.qemu_kvm;
      virtualisation.spiceUSBRedirection.enable = true;
      virtualisation.libvirtd.qemu.swtpm.enable = true;

      environment.systemPackages = with pkgs; [
        virt-manager
        virtiofsd
      ];

      elevate.user.groups = [ "libvirtd" ];
    })

    (mkIf (cfg.gpu-passthrough) {
      boot = {
        kernelParams = [
          "amd_iommu=on" "iommu=pt"
          "vfio-pci.ids=10de:1b83,10de:10f0"
          "rd.driver.pre=vfio-pci"
        ];
        initrd.kernelModules = [ "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ];
        # RTX 3060: 10de:2489,10de:228b # TODO: system doesn't boot when passing through this GPU :(
        # GTX 1060: 10de:1b83,10de:10f0
      };
    })
  ];
}
