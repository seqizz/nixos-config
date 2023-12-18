{ stdenv
, lib
, fetchFromGitHub
, python3Packages
}:
python3Packages.buildPythonPackage rec {

  pname = "pyedid";
  version = "unstable-2023-08-01";

  src = fetchFromGitHub {
    owner = "dd4e";
    repo = "pyedid";
    rev = "7ce72fb5c9d2da73d9cb46a97a4aebdb0256f64e";
    sha256 = "1rsn48zkq5wlfvsx9hyikzc1xjx9c7gbc6ksdcd2yiakpybkamfz";
  };

  propagatedBuildInputs = with python3Packages; [
    requests
  ];

  doInstallCheck = false;
  doCheck = false;

  meta = with lib; {
    description = "Python library for parsing EDID";
    homepage = https://github.com/dd4e/pyedid;
    license = licenses.mit;
    maintainers = [ "seqizz" ] ;
    platforms = platforms.linux;
  };
}
