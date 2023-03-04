{ config, pkgs, ... }:
{
  imports = [
    ../../programs/syncthing
    ../../programs/vms/configuration.nix
  ];

  elevate.user = {
    enable = true;
    name = "mathias";
    email = "mathias@magnusson.space";
    description = "Mathias";
    groups = [ "networkmanager" "docker" "dialout" "libvirtd" ];
  };

  environment.systemPackages = with pkgs; [
    # Command line tools
    neovim xclip killall file lazygit jq ffmpeg unzip pgcli xxd

    # Dependencies for some neovim plugins
    tree-sitter ripgrep fd

    # Compilers and interpreters
    zig gcc swiProlog gnumake jdk

    # Language servers
    java-language-server rnix-lsp

    # CTF
    ghidra binary-ninja

    # Graphical
    firefox ungoogled-chromium slack spotify obsidian zoom-us
    obs-studio logisim-evolution qFlipper gimp
    (discord.override { nss = nss_latest; }) # override needed to open links
  ];

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
  # boot.binfmt.emulatedSystems = [ "riscv64-linux" "mipsel-linux" ];

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplip ];

  nixpkgs.config.allowUnfree = true;

  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 7d";
  nix.gc.dates = "weekly";

  /* services.mullvad-vpn.enable = true; */

  networking.nameservers = [ "1.1.1.1" ];

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  environment.variables = rec {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";

    XCOMPOSECACHE = "$HOME/.cache/compose-cache";
    GNUPG_HOME="$HOME/.local/share/gnupg";
    ENCORE_INSTALL = "$HOME/.local/share/encore";

    VISUAL = "nvim";
    EDITOR = "nvim";
  };

  elevate.path = [
    "$HOME/.local/share/encore/bin"
  ];

  elevate.apps.alacritty.enable = true;
  elevate.apps.steam.enable = true;
  elevate.cli-apps.fish.enable = true;
  elevate.cli-apps.git.enable = true;
  elevate.cli-apps.helix.enable = true;
  elevate.cli-apps.ssh.enable = true;
  elevate.compilers.go.enable = true;
  elevate.compilers.haskell.enable = true;
  elevate.compilers.node.enable = true;
  elevate.compilers.python.enable = true;
  elevate.compilers.rust.enable = true;
  elevate.security.yubikey.enable = true;
}
