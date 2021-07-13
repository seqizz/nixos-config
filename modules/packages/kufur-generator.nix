{ stdenv
, fetchFromGitHub
, python3Packages
}:
python3Packages.buildPythonPackage rec {

  pname = "kufur-generator";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "seqizz";
    repo = "kufur-generator";
    rev = "5a049c6";
    sha256 = "0rcchgrb2562d4hnvsq6mia86l6v8rw8x23l968cmkj79f0ami06";
  };

  propagatedBuildInputs = with python3Packages; [
    python-telegram-bot
  ];

  doInstallCheck = false;
  doCheck = false;

  meta = with stdenv.lib; {
    description = "Awesome swears";
    homepage = https://github.com/seqizz/kufur-generator;
    license = licenses.mit;
    maintainers = [ "seqizz" ] ;
    platforms = platforms.linux;
  };
}
