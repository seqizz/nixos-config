{ lib
, fetchgit
, python3Packages
}:
python3Packages.buildPythonPackage rec {

  pname = "comar-generator";
  version = "unstable-2022-05-20";

  src = fetchgit {
    url = "https://git.gurkan.in/gurkan/comar-generator.git";
    rev = "310e480c8491d9ea53afe64ba6a607e2acf1766a";
    sha256 = "11x0lkdgpb5qhcs0v128mng73bfq1sgjmclw2fqzgiv087rndvgs";
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
