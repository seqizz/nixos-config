{ stdenv
, lib
, fetchurl
}:

stdenv.mkDerivation rec {
  name = "rustypaste-cli";
  version = "0.4.0";

  src = fetchurl {
    url = "https://github.com/orhun/rustypaste-cli/releases/download/v0.4.0/rustypaste-cli-0.4.0-x86_64-unknown-linux-musl.tar.gz";
    sha256 = "1yhfryqbppabbx2rpp96ma7h9bvl67c63l8jgxb3f3hk1zndk6dd";
  };

  unpackPhase = ''
    tar xvf ${src}
  '';

  installPhase = ''
    install -m755 -D rustypaste-cli-${version}/rpaste $out/bin/rpaste
  '';

  meta = with lib; {
    homepage = https://github.com/orhun/rustypaste-cli;
    description = "A minimal file upload/pastebin service, cli tool";
    platforms = platforms.linux;
    maintainers = with maintainers; [ seqizz ];
  };
}
