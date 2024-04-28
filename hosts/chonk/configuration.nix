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

  elevate.virtualisation.vfio.enable = true;
  specialisation.no-gpu-passthrough.configuration = {
    boot.loader.grub.configurationName = "Disable GPU passthrough";
    elevate.virtualisation.vfio.enable = lib.mkForce false;
  };

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  environment.systemPackages = with pkgs; [
    nvtop
    cudatoolkit
  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;

  boot.supportedFilesystems = [ "ntfs" ];

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  services.xserver = {
    videoDrivers = [ "nvidia" ];
    displayManager.setupCommands = "${pkgs.xorg.xrandr}/bin/xrandr " +
      "--output DP-0 --mode 1920x1080 --rate 144 --pos 0x0 " +
      "--output DP-2 --mode 1920x1080 --rate 144 --pos 1920x0 --primary || :";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

  nixpkgs.hostPlatform = "x86_64-linux";
}
