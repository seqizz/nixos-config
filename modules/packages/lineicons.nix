{ stdenv, lib, fetchurl, unzip }:

let
  name = "lineicons";
  version = "0.0.1";
  sha256 = "13xdwx9ijdfdsi5qx1s7w77jjngnp598mfcbzhmf2q2ypv5gx0nn";
in
stdenv.mkDerivation {

  inherit name;

  src = fetchurl {
    url = "https://lineicons.com/download/23710/";
    inherit sha256;
  };

  buildInputs = [ unzip ];

  dontUnpack = true;
  dontBuild = true;

  installPhase = ''
    cp "$src" icons.zip
    unzip icons.zip
    install -m444 -Dt $out/share/fonts/truetype WebFont/fonts/LineIcons.ttf
  '';

  meta = with lib; {
    description = "LineIcons - TTF Font";
    homepage = "http://lineicons.com/";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = with maintainers; [ seqizz ];
  };
}
