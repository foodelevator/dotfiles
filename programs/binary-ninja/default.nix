{ pkgs ? import <nixpkgs> {}, ... }:

with pkgs;

stdenv.mkDerivation rec {
  name = "binary-ninja-demo";
  buildInputs = [
    autoPatchelfHook makeWrapper unzip stdenv.cc.cc.lib dbus
    libGL glib fontconfig xorg.libXi xorg.libXrender

    libxkbcommon xorg.xcbutilwm xorg.xcbutilimage xorg.xcbutilkeysyms
    xorg.xcbutilrenderutil
  ];
  src = fetchurl {
    url = "https://cdn.binary.ninja/installers/BinaryNinja-demo.zip";
    sha256 = "sha256-dFUQg+8AUD2md/nFsnsK3/Sxl+7gcqE79gVQIixvxpg=";
  };

  buildPhase = ":";
  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/opt
    cp -r * $out/opt
    chmod +x $out/opt/binaryninja
    makeWrapper $out/opt/binaryninja \
        $out/bin/binaryninja \
        --prefix "QT_XKB_CONFIG_ROOT" ":" "${xkeyboard_config}/share/X11/xkb"
  '';
}
