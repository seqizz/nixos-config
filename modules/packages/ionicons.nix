{ lib, fetchFromGitHub }:

let
  version = "5.2.3";
  sha256 = "05s46illx51cbisp38ywsanhrqs68nyyjw1c0ngf1zsqbj16r08f";
in
fetchFromGitHub {
  name = "ionicons-${version}";

  owner = "ionic-team";
  repo = "ionicons";
  rev = "v${version}";

  postFetch = ''
    tar xf $downloadedFile --strip=1
    install -m444 -Dt $out/share/fonts/truetype docs/fonts/ionicons.ttf
  '';

  inherit sha256;

  meta = with lib; {
    description = "Ionicons - TTF Font";
    longDescription = ''
      Premium hand-crafted icons built by Ionic
    '';
    homepage = "http://ionicons.com/";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = with maintainers; [ seqizz ];
  };
}
