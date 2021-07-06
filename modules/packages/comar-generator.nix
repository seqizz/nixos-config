{ lib
, python3Packages
}:
python3Packages.buildPythonPackage rec {

  pname = "comar-generator";
  version = "1.0.0";

  src = builtins.fetchGit {
    url = "https://git.gurkan.in/gurkan/comar-generator.git";
    ref = "master";
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
