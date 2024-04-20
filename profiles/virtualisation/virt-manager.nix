{ pkgs, ... }:
{
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.package = pkgs.qemu_kvm;
  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.libvirtd.qemu.swtpm.enable = true;
  programs.dconf.enable = true; # Makes virt-manager remeber the last connection.

  environment.systemPackages = with pkgs; [
    virt-manager
    virtiofsd
  ];

  environment.variables = {
    LIBVIRT_DEFAULT_URI = "qemu:///system";
  };

  elevate.user.groups = [ "libvirtd" ];
}
