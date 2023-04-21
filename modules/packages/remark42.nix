{ stdenv
, lib
, fetchurl
}:

stdenv.mkDerivation rec {
  name = "remark42-${version}";
  version = "1.11.3";

  src = fetchurl {
    url = "https://github.com/umputun/remark42/releases/download/v1.11.3/remark42.linux-amd64.tar.gz";
    sha256 = "0kxiz3na4s806vlsrqyma7gc5x2yc4h307hqz1wm4ds925gl4wrq";
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
