{ stdenv
, lib
, fetchurl
}:
stdenv.mkDerivation rec {
  version = "0.6.2";
  name = "rustypaste";

  src = fetchurl {
    url = "https://github.com/orhun/rustypaste/releases/download/v${version}/rustypaste-${version}-x86_64-unknown-linux-musl.tar.gz";
    sha256 = "1wh0a18q8lphcc0k2f7c4sz695q00n88q1i5nhl1rdnnwnsbqqg2";
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
