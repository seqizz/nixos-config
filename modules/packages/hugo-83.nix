{ stdenv
, lib
, fetchurl
}:

stdenv.mkDerivation rec {
  name = "hugo-83-${version}";
  version = "0.83.1";

  src = fetchurl {
    url = "https://github.com/gohugoio/hugo/releases/download/v0.83.1/hugo_0.83.1_Linux-64bit.tar.gz";
    sha256 = "0bjl7v25h0kn301hx2c7bqg7j3illxkhi8dv828f6db9fla66xav";
  };

  unpackPhase = ''
    tar xvf ${src}
  '';

  installPhase = ''
    install -m755 -D hugo $out/bin/hugo-83
  '';

  meta = with lib; {
    homepage = https://gohugo.io;
    description = "A static site generator, older version to support my stuff";
    platforms = platforms.linux;
    maintainers = with maintainers; [ seqizz ];
  };
}
