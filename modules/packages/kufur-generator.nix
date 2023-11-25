{ stdenv
, lib
, fetchFromGitHub
, python3Packages
}:
python3Packages.buildPythonPackage rec {

  pname = "kufur-generator";
  version = "unstable-2023-11-25";

  src = fetchFromGitHub {
    owner = "seqizz";
    repo = "kufur-generator";
    rev = "71af1be8a5831623cbe0591bd8349e41117ca501";
    sha256 = "0jg80zcv6g1y0v6gmkazv6iyb4zcb0q2p43n101h1yy3fbahihkn";
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
