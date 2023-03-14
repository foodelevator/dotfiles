{ fetchurl
, lib
, stdenv
, makeWrapper
, ncurses5
, autoPatchelfHook
, gtk2
, xorg
, nspr
, nss_latest
, alsa-lib
, unixODBC
}:
let
  majorMinor = "18.2";
  patch = "45405";
  version = "${majorMinor}.${patch}";
  arch = "x86_64";

  deb = fetchurl {
    url = "https://www.dyalog.com/uploads/php/download.dyalog.com/download.php"
      + "?file=${majorMinor}/linux_64_${version}_unicode.${arch}.deb";
    hash = "sha256-pA/WGTA6YvwG4MgqbiPBLKSKPtLGQM7BzK6Bmyz5pmM=";
  };
in
stdenv.mkDerivation {
  name = "dyalog-${version}";
  src = deb;
  buildInputs = [
    autoPatchelfHook
    makeWrapper
    gtk2
    ncurses5
    nspr
    nss_latest
    alsa-lib
  ] ++ (with xorg; [
    libXdamage
    libXtst
    libXScrnSaver
    unixODBC
  ]);
  unpackPhase = "ar x $src";
  installPhase = ''
    mkdir -p $out
    tar -C $out -xf data.tar.gz
    mkdir -p $out/bin
    makeWrapper $out/opt/mdyalog/${majorMinor}/64/unicode/dyalog \
      $out/bin/dyalog
    makeWrapper $out/opt/mdyalog/${majorMinor}/64/unicode/scriptbin/dyalogscript \
      $out/bin/dyalogscript
    sed "s/\/opt/$(echo $out | sed 's/\//\\\//g')\/opt/" \
      "$out/opt/mdyalog/${majorMinor}/64/unicode/scriptbin/dyalogscript" \
      > "$out/bin/dyalogscript"
  '';
}
