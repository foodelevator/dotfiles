{ config, pkgs, ... }:
{
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;

  imports =
    [
      ../../de/i3/configuration.nix
    ];

  elevate.apps.openrgb.enable = true;
  elevate.apps.obs.enable = true;

  elevate.archetypes.workstation.enable = true;

  environment.systemPackages = with pkgs; [
    lutris
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
      "--output HDMI-1         --mode 1920x1080 --rate 60  --pos 0x0 " +
      "--output DP-0 --primary --mode 1920x1080 --rate 166 --pos 1920x0 " +
      "--output DP-2           --mode 1920x1080 --rate 144 --pos 3840x0";
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
