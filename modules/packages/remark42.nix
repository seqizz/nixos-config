{ stdenv
, lib
, fetchurl
}:

stdenv.mkDerivation rec {
  name = "remark42-${version}";
  version = "1.9.0";

  src = fetchurl {
    url = "https://github.com/umputun/remark42/releases/download/v${version}/remark42.linux-amd64.tar.gz";
    sha256 = "0vbfra85g7w4dj4pfh8jxaimhvw7x9n9y84mkh137vbcfnmpibgz";
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
