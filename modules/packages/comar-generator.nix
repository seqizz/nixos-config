{ lib
, fetchgit
, python3Packages
}:
python3Packages.buildPythonPackage rec {

  pname = "comar-generator";
  version = "unstable-2023-06-26";

  src = fetchgit {
    url = "https://git.gurkan.in/gurkan/comar-generator.git";
    rev = "ba299266adc911ff2d2e653367116f29f4c4fabf";
    sha256 = "0b0mbspg8z62ymwisx8ay38h1nii41agxdk8km65fiqlvx84scrh";
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
