{ lib
, fetchgit
, python3Packages
}:
python3Packages.buildPythonPackage rec {

  pname = "comar-generator";
  version = "unstable-2022-03-22";

  src = fetchgit {
    url = "https://git.gurkan.in/gurkan/comar-generator.git";
    rev = "24fe4e455cc9b18e3b583c3e086e3536b564f35a";
    sha256 = "0jqgdbqyws2i4xdfqks1fll28kd26iyp3gzh7v1jq5zpzqs0qfzd";
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
