{ stdenv
, lib
, fetchurl
}:
let
  version = "0.8.2";
in
stdenv.mkDerivation rec {
  inherit version;
  name = "rustypaste";

  src = fetchurl {
    url = "https://github.com/orhun/rustypaste/releases/download/v${version}/rustypaste-${version}-x86_64-unknown-linux-musl.tar.gz";
    sha256 = "1yrz49gxq1pksdh2ymkcrji44kv0wvxbr6whs00z8br96kajh8j8";
  };

  unpackPhase = ''
    tar xvf ${src}
  '';

  installPhase = ''
    install -m755 -D rustypaste-${version}/rustypaste $out/bin/rustypaste
  '';

  meta = with lib; {
    homepage = https://github.com/orhun/rustypaste;
    description = "A minimal file upload/pastebin service";
    platforms = platforms.linux;
    maintainers = with maintainers; [ seqizz ];
  };
}
