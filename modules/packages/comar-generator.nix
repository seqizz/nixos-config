{ lib
, fetchgit
, python3Packages
}:
python3Packages.buildPythonPackage rec {

  pname = "comar-generator";
  version = "1.0.0";

  src = fetchgit {
    url = "https://git.gurkan.in/gurkan/comar-generator.git";
    rev = "51dd492";
    sha256 = "14a9zlrpnh17151bp26s9yjyhdahjifc2r89k4aj4jivmh4p5yhf";
  };

  propagatedBuildInputs = with python3Packages; [
    python-telegram-bot
  ];

  doInstallCheck = false;
  doCheck = false;

  meta = with lib; {
    description = "Turkish right wing nonsense";
    homepage = https://git.gurkan.in/gurkan/comar-generator.git;
    license = licenses.mit;
    maintainers = [ "seqizz" ] ;
    platforms = platforms.linux;
  };
}
