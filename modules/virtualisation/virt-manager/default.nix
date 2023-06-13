{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.virtualisation.virt-manager;
in
{
  options.elevate.virtualisation.virt-manager = {
    enable = mkEnableOption "virt-manager & libvirtd";
  };

  config = mkIf cfg.enable {
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
    virtualisation.libvirtd.qemu.swtpm.enable = true;

    environment.systemPackages = with pkgs; [
      virt-manager
      virtiofsd
    ];

    elevate.user.groups = [ "libvirtd" ];
  };
}
