{ pkgs, profiles, ... }:
{
  imports = with profiles; [
    system.env
    system.locale
    system.nix

    cli-apps.fish
    cli-apps.git
  ];

  environment.systemPackages = with pkgs; [
    neovim /* dependencies for some plugins: */ tree-sitter ripgrep fd
    pciutils usbutils

    xclip killall file jq unzip xxd rlwrap xorg.xhost
  ];

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
