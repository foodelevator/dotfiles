{ config, pkgs, ... }:
{

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

  virtualisation.docker.enable = true;
  # boot.binfmt.emulatedSystems = [ "riscv64-linux" "mipsel-linux" ];

  /* services.mullvad-vpn.enable = true; */

  networking.nameservers = [ "1.1.1.1" ];

  environment.variables = {
    ENCORE_INSTALL = "$HOME/.local/share/encore";

    VISUAL = "nvim";
    EDITOR = "nvim";
  };

  elevate.path = [
    "$HOME/.local/share/encore/bin"
  ];

  elevate.apps.alacritty.enable = true;
  elevate.apps.steam.enable = true;
  elevate.apps.syncthing.enable = true;
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
  elevate.system.env.enable = true;
  elevate.system.fonts.enable = true;
  elevate.system.locale.enable = true;
  elevate.system.nix.enable = true;
  elevate.system.printing.enable = true;
  elevate.virtualisation.virt-manager.enable = true;

  elevate.user = {
    enable = true;
    name = "mathias";
    email = "mathias@magnusson.space";
    description = "Mathias";
    groups = [ "networkmanager" "docker" "dialout" ];
  };
}
