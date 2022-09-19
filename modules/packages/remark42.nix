{ stdenv
, lib
, fetchurl
}:

stdenv.mkDerivation rec {
  name = "remark42-${version}";
  version = "1.10.1";

  src = fetchurl {
    url = "https://github.com/umputun/remark42/releases/download/v${version}/remark42.linux-amd64.tar.gz";
    sha256 = "119rjkyh6v5v2m6yj1sgkkkc5k95i8dpvzazbj20b8b7k51j4jlb";
  };

  unpackPhase = ''
    tar xvf $src
  '';

  installPhase = ''
    install -m755 -D remark42.linux-amd64 $out/bin/remark42
  '';

  meta = with lib; {
    homepage = https://remark42.com;
    description = "A comment engine";
    platforms = platforms.linux;
    maintainers = with maintainers; [ seqiz ];
  };
}
