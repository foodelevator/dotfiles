{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.security.yubikey;

  dir = "$HOME/.local/share/passage";
  store = "${dir}/store";

  prompt = pkgs.writeShellScriptBin "rofi-passage-prompt" ''
    escstore=$(echo "${store}" | sed \
      -e 's/\//\\\//g' \
      -e 's/\./\\./g')
    passwords=$(find "${store}" -name \*.age | \
      sed -E "s/$escstore\/(.*)\.age/\1/")

    password=$(printf '%s\n' "''${passwords[@]}" | \
      ${pkgs.rofi}/bin/rofi -dmenu -sort -matching fuzzy)

    [[ -n $password ]] || exit

    out=$(mktemp)
    passage -c "$password" >$out 2>$out || rofi -e "$(cat $out)"
    rm $out
  '';
in
{
  options.elevate.security.yubikey = {
    enable = mkEnableOption "yubikey for login and sudo and opt app";
  };

  config = mkIf cfg.enable {
    security.pam.services = {
      login.u2fAuth = true;
      sudo.u2fAuth = true;
    };

    services.yubikey-agent.enable = true;

    environment.systemPackages = with pkgs; [
      pam_u2f
      yubikey-manager
      yubioath-flutter

      age
      age-plugin-yubikey

      (passage.overrideAttrs (_: { extraPath = makeBinPath [age git xclip tree qrencode]; }))

      prompt
    ];

    environment.variables = {
      PASSAGE_DIR = store;
      PASSAGE_IDENTITIES_FILE = "${dir}/identities";
      PASSAGE_EXTENSIONS_DIR = "${dir}/extensions";
    };
  };
}
