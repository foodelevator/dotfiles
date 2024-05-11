{ pkgs, profiles, ... }:
{
  imports = with profiles; [
    system.env
    system.locale
    system.nix

    cli-apps.fish
    cli-apps.git
    cli-apps.lazygit
  ];

  environment.systemPackages = with pkgs; [
    neovim /* dependencies for some plugins: */
    tree-sitter
    ripgrep
    fd

    pciutils
    usbutils

    killall
    file
    jq
    unzip
    xxd
    rlwrap
  ];

  environment.defaultPackages = with pkgs; [ rsync strace ]; # nano & perl removed

  environment.variables = {
    VISUAL = "nvim";
    EDITOR = "nvim";
  };

  elevate.user = {
    enable = true;
    name = "mathias";
    email = "mathias@magnusson.space";
    description = "Mathias";
  };
}
