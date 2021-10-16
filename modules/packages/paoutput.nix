{ stdenv, fetchgit , pulseaudioFull }:

stdenv.mkDerivation {
  name = "paoutput";
  version = "0.1";

  src = fetchgit {
    url = "https://git.gurkan.in/gurkan/paoutput.git";
    rev = "223a6af7b9f1bad06f53f706807d2b709dba89d9";
    sha256 = "1f1cmb9wchxr3g9hdswzlzr11wbqy58cqz56dryp8wpw3brirb02";
  };

  buildInputs = [ pulseaudioFull ];

  installPhase = ''
    mkdir -p $out/bin
    cp paoutput $out/bin
  '';
}
