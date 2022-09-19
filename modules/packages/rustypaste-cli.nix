{ stdenv
, lib
, fetchurl
}:

stdenv.mkDerivation rec {
  name = "rustypaste-cli";
  version = "0.1.11";

  src = fetchurl {
    url = "https://github.com/orhun/rustypaste-cli/releases/download/v${version}/rustypaste-cli-${version}-x86_64-unknown-linux-musl.tar.gz";
    sha256 = "0mazpq497vyzd77h1pngn77ghj6n5rnh7290b4dl41y0fay9wnv5";
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
