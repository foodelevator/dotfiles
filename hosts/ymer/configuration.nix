{ config, pkgs, lib, profiles, ... }:
{
  imports = with profiles; [
    apps.openrgb
    apps.obs

    desktops.gnome
    archetypes.workstation

    services.wireguard
    services.sshd
  ];

  fileSystems."${config.elevate.user.home}/nfs" = {
    device = "192.168.1.5:/export/mathias";
    fsType = "nfs";
  };

  elevate.virtualisation.vfio.enable = false;
  specialisation.no-gpu-passthrough.configuration = {
    boot.loader.grub.configurationName = "Enable passthrough for GTX 1060";
    elevate.virtualisation.vfio.enable = lib.mkForce true;
  };

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  environment.systemPackages = with pkgs; [
    cudatoolkit
  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;

  boot.supportedFilesystems = [ "ntfs" ];

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  services.xserver.videoDrivers = [ "nvidia" ];

  # Should work but (makes gnome be able to run wayland and) if running X11, gnome crashes when monitors change
  # boot.kernelParams = [ "nvidia-drm.modeset=1" ];
  # services.xserver.displayManager.setupCommands = "autorandr --load default";
  # services.autorandr.enable = true;
  # services.autorandr.profiles.default = {
  #   fingerprint = {
  #     "DP-2" = "00ffffffffffff0006b3012400000000251e0104a5341d78ff3205a3544d9c270d5054254b00457c617c818081bca9c0a9fcb300b33c023a801871382d40582c450055502100001e000000fd003091b8b827010a202020202020000000fc0056473234395131520a20202020000000ff004c394c4d44573030363934330a014202032bf148020405901113141f230907078301000067030c003000384e6d1a0000020130a5000000000000046d80a0703828403020350055502100001ed15a80a0703828403020350055502100001ead8280a0703828403020350055502100001eb29580a0703828403040350055502100001e000000000000000000000000c6";
  #     "DP-4" = "00ffffffffffff001e6d715bdbd5050001200104b53c22789f0331a6574ea2260d5054a54b80317c4568457c617c8168818081bc953ccb8480a07038374030203a0055502100001a023a801871382d40582c4500132a2100001e000000fd003090a0a03c010a202020202020000000fc004c4720554c545241474541520a01c6020323f1230907074b010203041112131f903f0083010000e305c000e60605016059288048801871382d40582c4500132a2100001e866f80a07038404030203500132a2100001efe5b80a07038354030203500132a21000018011d007251d01e206e285500132a2100001e000000000000000000000000000000000000000055";
  #     "HDMI-1-0" = "00ffffffffffff001e6d705bdbd5050001200103803c2278ea0331a6574ea2260d5054a54b80317c4568457c617c8168818081bc953ccb8480a07038374030203a00132a2100001a000000ff003230314e54464142383432370a000000fd0030901ea021000a202020202020000000fc004c4720554c545241474541520a010b020347f12309070750010203041112131f903f405d5e5f60616d030c002000b83c20006001020367d85dc401788003e30f00c0e305c000e6060501605928681a00000101309000023a801871382d40582c4500132a2100001e866f80a07038404030203500132a2100001efa5b80a07038354030203500132a21000018000013";
  #   };
  #   config = {
  #     "DP-2" = {
  #       position = "0x0";
  #       mode = "1920x1080";
  #       rate = "144";
  #     };
  #     "DP-4" = {
  #       primary = true;
  #       position = "1920x0";
  #       mode = "1920x1080";
  #       rate = "144";
  #     };
  #     "HDMI-1-0".enable = false;
  #   };
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

  nixpkgs.hostPlatform = "x86_64-linux";
}
