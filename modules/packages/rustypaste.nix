{ stdenv
, lib
, fetchurl
}:
stdenv.mkDerivation rec {
  version = "0.7.1";
  name = "rustypaste";

  src = fetchurl {
    url = "https://github.com/orhun/rustypaste/releases/download/v${version}/rustypaste-${version}-x86_64-unknown-linux-musl.tar.gz";
    sha256 = "05pz1axl4j9abail2f6sfzqv76l38l531kpykfslc98vqih1y8yb";
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
