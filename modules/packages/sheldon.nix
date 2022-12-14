{ stdenv
, lib
, fetchurl
}:

stdenv.mkDerivation rec {
  name = "sheldon";
  version = "0.7.1";

  src = fetchurl {
    url = "https://github.com/rossmacarthur/sheldon/releases/download/${version}/sheldon-${version}-x86_64-unknown-linux-musl.tar.gz";
    sha256 = "sha256-8zNBi7Ziyb+sG108NUMWyZwYNbiHIZOxUmtr+RKSB6Y=";
    # sha256 = "sha256-wkP+Luq9N68o1DpVmixohrgq0pv7ynKTe/Po5+sgxOg=";
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
