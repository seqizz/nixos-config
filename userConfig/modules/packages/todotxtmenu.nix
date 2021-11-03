{ stdenv
, lib
, fetchurl
}:

stdenv.mkDerivation rec {
  name = "todotxtmenu";
  version = "1.2.1";

  src = fetchurl {
    url = "https://github.com/firecat53/${name}/releases/download/v${version}/${name}_${version}_linux_amd64.tar.gz";
    sha256 = "0bd807fmiwprn8n1dkkdj76h797x0r1jycy3wxbip7dk2mfypp2s";
  };

  unpackPhase = ''
    tar xvf $src
  '';

  installPhase = ''
    install -m755 -D todotxtmenu $out/bin/todotxtmenu
  '';

  meta = with lib; {
    homepage = https://github.com/firecat53/todotxtmenu/;
    description = " Dmenu/Rofi script to manage todo.txt lists";
    platforms = platforms.linux;
    maintainers = with maintainers; [ seqiz ];
  };
}
