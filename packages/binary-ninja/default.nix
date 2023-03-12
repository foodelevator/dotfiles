{ fetchzip, buildFHSUserEnv, ... }:
let
  binary-ninja = fetchzip {
    url = "https://cdn.binary.ninja/installers/BinaryNinja-demo.zip";
    hash = "sha256-SGMVj+LR1bsSK+0Yeh1JXEokTHQl580n1M0IuMmE2xk=";
  };
in
buildFHSUserEnv {
  name = "binary-ninja";
  runScript = "${binary-ninja}/binaryninja";
  targetPkgs = pkgs:
  with pkgs; [
    libGL fontconfig xorg.libX11 xorg.libxcb
    libxkbcommon freetype qt6.qtbase
    zlib dbus
  ];
}
