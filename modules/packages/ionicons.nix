{ lib
, fetchFromGitHub
}:

let
  pname = "ionicons";
  version = "6.1.3";
in
fetchFromGitHub rec {
  owner = "ionic-team";
  repo = pname;
  rev = "v${version}";

  sha256 = "sha256-J7pldfswixYl9qznVFsY37rS2uvGDRpXSV3FUVTeKcY=";

  downloadToTemp = true;

  postFetch = ''
    cd $out
    install -Dm644 docs/fonts/ionicons.ttf -t $out/share/fonts/truetype/
  '';


  meta = with lib; {
    homepage = "https://ionicons.com";
    description = "Font from the Ionic mobile framework";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
