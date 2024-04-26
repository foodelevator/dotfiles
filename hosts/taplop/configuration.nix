{ pkgs, profiles, ... }:
{
  imports = with profiles; [
    desktops.gnome
    archetypes.workstation
    services.wireguard.client
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-60b63ab5-ed00-450a-8ad1-13c2572dcfd6".device = "/dev/disk/by-uuid/60b63ab5-ed00-450a-8ad1-13c2572dcfd6";
  boot.initrd.luks.devices."luks-60b63ab5-ed00-450a-8ad1-13c2572dcfd6".keyFile = "/crypto_keyfile.bin";

  hardware.opengl.extraPackages = [ pkgs.intel-ocl ];

  hardware.system76.enableAll = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

  nixpkgs.hostPlatform = "x86_64-linux";
}
