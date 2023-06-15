{ fetchurl, fetchzip, buildFHSUserEnv, writeTextFile, symlinkJoin }:
let
  binary-ninja = fetchzip {
    url = "https://cdn.binary.ninja/installers/BinaryNinja-demo.zip";
    hash = "sha256-SGMVj+LR1bsSK+0Yeh1JXEokTHQl580n1M0IuMmE2xk=";
  };
  userEnv = buildFHSUserEnv {
    name = "binary-ninja";
    runScript = "${binary-ninja}/binaryninja";
    targetPkgs = pkgs:
    with pkgs; [
      libGL fontconfig xorg.libX11 xorg.libxcb
      libxkbcommon freetype qt6.qtbase
      zlib dbus
    ];
  };
  icon = fetchurl {
    url =
    "https://raw.githubusercontent.com/Vector35/binaryninja-api/1ae01b140d99f07c86c9f56374e26a062ff34c0c/docs/images/logo.png";
    hash = "sha256-y1L815ci+yh0dX0fB2x8t5Lj77DdlD9G9GGQ0/G+JJs=";
  };
  desktop = writeTextFile {
    name = "binary-ninja.desktop";
    destination = "/share/applications/binary-ninja.desktop";
    text = ''
      [Desktop Entry]
      Categories=Development
      Exec=${userEnv}/bin/binary-ninja
      Name=Binary Ninja
      Icon=${icon}
      Type=Application
    '';
  };
in symlinkJoin {
  name = "binary-ninja";
  paths = [
    userEnv
    desktop
  ];
}
