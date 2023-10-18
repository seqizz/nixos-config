{ stdenv
, lib
, fetchFromGitHub
, python3Packages
}:
python3Packages.buildPythonPackage rec {

  pname = "kufur-generator";
  version = "unstable-2023-09-20";

  src = fetchFromGitHub {
    owner = "seqizz";
    repo = "kufur-generator";
    rev = "328004e2af4f178d0ae61cdee8af035585348a8c";
    sha256 = "1wp44n0a2whf4qg2dcc1ycpzlb9i560ikr8ka4q80r8pd7wg6ph3";
  };

  propagatedBuildInputs = with python3Packages; [
    python-telegram-bot
  ];

  doInstallCheck = false;
  doCheck = false;

  meta = with lib; {
    description = "Awesome swears";
    homepage = https://github.com/seqizz/kufur-generator;
    license = licenses.mit;
    maintainers = [ "seqizz" ] ;
    platforms = platforms.linux;
  };
}
