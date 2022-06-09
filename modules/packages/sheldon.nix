{ stdenv
, lib
, fetchurl
}:

stdenv.mkDerivation rec {
  name = "sheldon";
  version = "0.6.6";

  src = fetchurl {
    url = "https://github.com/rossmacarthur/sheldon/releases/download/${version}/sheldon-${version}-x86_64-unknown-linux-musl.tar.gz";
    sha256 = "sha256-9JeE0XRblaZL8BObwm8DlxQ7ahyr3GktqykIYL0GNY0=";
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
