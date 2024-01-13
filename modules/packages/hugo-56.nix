{ stdenv
, lib
, fetchurl
}:

stdenv.mkDerivation rec {
  name = "hugo-56-${version}";
  version = "0.56.1";

  src = fetchurl {
    url = "https://github.com/gohugoio/hugo/releases/download/v0.56.1/hugo_0.56.1_Linux-64bit.tar.gz";
    sha256 = "0m4ayjz7v1g0i8w8wrlvb46z0d8sy7lhkg9vfx6qw04ijf7blax0";
  };

  unpackPhase = ''
    tar xvf ${src}
  '';

  installPhase = ''
    install -m755 -D hugo $out/bin/hugo-56
  '';

  meta = with lib; {
    homepage = https://gohugo.io;
    description = "A static site generator, older version to support my stuff";
    platforms = platforms.linux;
    maintainers = with maintainers; [ seqizz ];
  };
}
