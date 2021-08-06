{ stdenv
, lib
, fetchurl
}:

stdenv.mkDerivation rec {
  name = "rustypaste";
  version = "0.2.0";

  src = fetchurl {
    url = "https://github.com/orhun/rustypaste/releases/download/v${version}/rustypaste-${version}-x86_64-unknown-linux-musl.tar.gz";
    sha256 = "0dp6wfsxmnyk0a0189lqh3n7r5mivm9kzb39ddfvmpin9h84pgs1";
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
