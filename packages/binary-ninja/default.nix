{ fetchurl, fetchzip, buildFHSEnv, writeTextFile, symlinkJoin }:
let
  binary-ninja = fetchzip {
    url = "https://cdn.binary.ninja/installers/BinaryNinja-demo.zip";
    hash = "sha256-SGMVj+LR1bsSK+0Yeh1JXEokTHQl580n1M0IuMmE2xk=";
  };
  fhsEnv = buildFHSEnv {
    # Mostly copied from: https://gist.github.com/Ninja3047/256a0727e7ea09ab6c82756f11265ee1
    name = "binary-ninja";

    targetPkgs = pkgs:
      with pkgs; [
        dbus
        fontconfig
        freetype
        libGL
        libxkbcommon
        (python3.withPackages (ps: with ps; [ torch ]))
        xorg.libX11
        xorg.libxcb
        xorg.xcbutilimage
        xorg.xcbutilkeysyms
        xorg.xcbutilrenderutil
        xorg.xcbutilwm
        wayland
        zlib
      ];

    runScript = "${binary-ninja}/binaryninja";

    meta = {
      description = "BinaryNinja";
      platforms = [ "x86_64-linux" ];
    };
  };
  icon = fetchurl {
    url = "https://raw.githubusercontent.com/Vector35/binaryninja-api/1ae01b140d99f07c86c9f56374e26a062ff34c0c/docs/images/logo.png";
    hash = "sha256-y1L815ci+yh0dX0fB2x8t5Lj77DdlD9G9GGQ0/G+JJs=";
  };
  desktop = writeTextFile {
    name = "binary-ninja.desktop";
    destination = "/share/applications/binary-ninja.desktop";
    text = ''
      [Desktop Entry]
      Categories=Development
      Exec=${fhsEnv}/bin/binary-ninja
      Name=Binary Ninja
      Icon=${icon}
      Type=Application
      MimeType=application/x-executable;application/x-pie-executable;application/x-sharedlib
    '';
  };
in
symlinkJoin {
  name = "binary-ninja";
  paths = [
    fhsEnv
    desktop
  ];
}
