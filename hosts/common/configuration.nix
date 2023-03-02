{ config, pkgs, ... }:
{
  imports = [
    ../../programs/syncthing
    ../../programs/steam
    ../../programs/ssh
    ../../programs/vms/configuration.nix
    ../../programs/python
    ../../programs/fish
    ../../programs/git
    ../../programs/helix
    ../../programs/alacritty
    ../../u2f/configuration.nix
  ];

  users.users.mathias = {
    isNormalUser = true;
    description = "mathias";
    extraGroups = [ "wheel" "networkmanager" "docker" "dialout" "libvirtd" ];
    shell = pkgs.fish;
  };

  environment.systemPackages = with pkgs; [
    # Command line tools
    neovim git fish xclip killall file lazygit jq ffmpeg unzip pgcli xxd lf

    # Dependencies for some neovim plugins
    tree-sitter ripgrep fd

    # Compilers and interpreters
    zig go gcc swiProlog ghc gnumake nodejs rustup jdk

    # Language servers
    java-language-server gopls rnix-lsp haskell-language-server

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
    CABAL_DIR = "$HOME/.local/share/cabal";
    GNUPG_HOME="$HOME/.local/share/gnupg";
    GOPATH = "$HOME/.local/share/go";
    npm_config_prefix = "$HOME/.local/share/npm";
    npm_config_cache = "$HOME/.cache/npm";
    CARGO_HOME = "$HOME/.local/share/cargo";
    CARGO_TARGET_DIR = "$HOME/.cache/target";
    RUSTUP_HOME = "$HOME/.local/share/rustup";
    ENCORE_INSTALL =  "$HOME/.local/share/encore";

    VISUAL = "nvim";
    EDITOR = "nvim";

    PATH = let paths = [
      "${GOPATH}/bin"
      "${npm_config_prefix}/bin"
      "${ENCORE_INSTALL}/bin"
    ]; in pkgs.lib.concatStringsSep ":" paths + ":$PATH";
  };
}
