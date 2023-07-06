{ stdenv
, lib
, fetchurl
}:

stdenv.mkDerivation rec {
  name = "sheldon";
  version = "0.7.3";

  src = fetchurl {
    url = "https://github.com/rossmacarthur/sheldon/releases/download/0.7.3/sheldon-0.7.3-x86_64-unknown-linux-musl.tar.gz";
    sha256 = "06spb45553s2rqjdsivzskf64076yabs6axis7gxjwxlpzalaz8h";
  };

  unpackPhase = ''
    tar xvf ${src}
  '';

  installPhase = ''
    install -m755 -D sheldon $out/bin/sheldon
  '';

  meta = with lib; {
    homepage = https://github.com/rossmacarthur/sheldon;
    description = "Fast, configurable, shell plugin manager";
    platforms = platforms.linux;
    maintainers = with maintainers; [ seqizz ];
  };
}
