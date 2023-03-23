{ lib
, fetchgit
, python3Packages
}:
python3Packages.buildPythonPackage rec {

  pname = "comar-generator";
  version = "unstable-2023-03-15";

  src = fetchgit {
    url = "https://git.gurkan.in/gurkan/comar-generator.git";
    rev = "c95ddca0a723c335796a0e6da0ae7d1f8b620d0f";
    sha256 = "1gmx9h9299lgif9ag2mqjvmnlpf4pw3k86v08a91rh5llmqr72vs";
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
