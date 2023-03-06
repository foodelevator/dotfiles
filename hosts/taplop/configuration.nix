# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../de/gnome/configuration.nix
    ];

  elevate.archetypes.workstation.enable = true;

  environment.systemPackages = with pkgs; [
    vscode
    gnome.gnome-boxes
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

  networking.hostName = "taplop";

  hardware.system76.enableAll = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  time.timeZone = "Europe/Stockholm";

  hardware.pulseaudio.enable = false; # TODO: why do i have both pulseaudio and pipewire?

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.allowedTCPPortRanges = [ { from = 1716; to = 1764; } ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}

