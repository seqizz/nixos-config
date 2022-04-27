{ stdenv
, lib
, fetchFromGitHub
, python3Packages
}:
python3Packages.buildPythonPackage rec {

  pname = "kufur-generator";
  version = "unstable-2021-07-07";

  src = fetchFromGitHub {
    owner = "seqizz";
    repo = "kufur-generator";
    rev = "5a049c6d1686b09393bbfaa08f3e00f3babbaa95";
    sha256 = "0rcchgrb2562d4hnvsq6mia86l6v8rw8x23l968cmkj79f0ami06";
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
