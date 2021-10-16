{ stdenv
, lib
, fetchurl
}:

stdenv.mkDerivation rec {
  name = "rustypaste";
  version = "0.5.0";

  src = fetchurl {
    url = "https://github.com/orhun/rustypaste/releases/download/v${version}/rustypaste-${version}-x86_64-unknown-linux-musl.tar.gz";
    sha256 = "14chdzikw5f3ppicw45zqg4wk9vk102jvyzl2hmabhw971rk3ms9";
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
