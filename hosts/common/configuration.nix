{ config, pkgs, ... }:
{
  imports =
    [
      ../../programs/syncthing
      ../../programs/steam
      ../../programs/ssh
      ../../u2f/configuration.nix
    ];

  users.users.mathias = {
    isNormalUser = true;
    description = "mathias";
    extraGroups = [ "wheel" "networkmanager" "docker" "dialout" ];
    shell = pkgs.fish;
  };

  i18n.defaultLocale = "en_US.utf8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.utf8";
    LC_IDENTIFICATION = "sv_SE.utf8";
    LC_MEASUREMENT = "sv_SE.utf8";
    LC_MONETARY = "sv_SE.utf8";
    LC_NAME = "sv_SE.utf8";
    LC_NUMERIC = "sv_SE.utf8";
    LC_PAPER = "sv_SE.utf8";
    LC_TELEPHONE = "sv_SE.utf8";
    LC_TIME = "sv_SE.utf8";
  };

  virtualisation.docker.enable = true;
  boot.binfmt.emulatedSystems = [];

  nixpkgs.config.allowUnfree = true;

  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 7d";
  nix.gc.dates = "weekly";

  services.mullvad-vpn.enable = true;

  environment.systemPackages = with pkgs; [
    neovim
    git
    fish

    jdk
  ];

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  environment.variables = {
    XCOMPOSECACHE = "$HOME/.cache/compose-cache";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
  };
}
