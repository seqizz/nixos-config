{ stdenv
, lib
, fetchFromGitHub
, python3Packages
}:
python3Packages.buildPythonPackage rec {

  pname = "kufur-generator";
  version = "unstable-2023-06-26";

  src = fetchFromGitHub {
    owner = "seqizz";
    repo = "kufur-generator";
    rev = "12a44019bda05466a2379cda8d33a590abf7e1a6";
    sha256 = "1p3i2vkcl3a2jzm4cn334bx8738k76s6v61w8x5i5nraknxipdkk";
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
