{ pkgs, lib, ... }:
let
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
    passage -c "$password" >$out 2>$out \
      && ${pkgs.libnotify}/bin/notify-send -t 2000 "$(cat $out)" \
      || rofi -e "$(cat $out)"
    rm $out
  '';

  # xdg-desktop-menu refuses if the name doesn't contain a -
  yubioath = pkgs.symlinkJoin {
    name = "yubioath";
    paths = [ pkgs.yubioath-flutter ];
    postBuild = ''
      mv "$out/share/applications/com.yubico.authenticator.desktop" \
        "$out/share/applications/yubico-authenticator.desktop"
    '';
  };
in
{
  services.yubikey-agent.enable = true;

  environment.systemPackages = with pkgs; [
    yubikey-manager
    yubioath

    age
    age-plugin-yubikey

    (passage.overrideAttrs (_: { extraPath = lib.makeBinPath [ age git xclip tree qrencode ]; }))

    prompt
  ];

  environment.variables = {
    PASSAGE_DIR = store;
    PASSAGE_IDENTITIES_FILE = "${dir}/identities";
    PASSAGE_EXTENSIONS_DIR = "${dir}/extensions";
  };
}
