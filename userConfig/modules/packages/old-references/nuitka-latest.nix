{ stdenv
, buildPythonPackage
, fetchFromGitHub
, vmprof
, pyqt4
, isPyPy
, pkgs
}:

let
  # scons is needed but using it requires Python 2.7
  # Therefore we create a separate env for it.
  scons = pkgs.python27.withPackages(ps: [ pkgs.scons ]);
in buildPythonPackage rec {
  version = "0.6.9.1";
  pname = "Nuitka";

  src = fetchFromGitHub {
    owner = "Nuitka";
    repo = "Nuitka";
    rev = "262d506035b3738f622fa01d9ce8e597deb417cf";
    sha256 = "0lyybhi8gaaafckjvpfchqqanvjx514p492l50gjdskzwi7mv6r0";
  };

  checkInputs = [ vmprof pyqt4 ];
  nativeBuildInputs = [ scons ];

  postPatch = ''
    patchShebangs tests/run-tests
  '' + stdenv.lib.optionalString stdenv.isLinux ''
    substituteInPlace nuitka/plugins/standard/ImplicitImports.py --replace 'locateDLL("uuid")' '"${pkgs.utillinux.out}/lib/libuuid.so"'
  '';

  # We do not want any wrappers here.
  postFixup = '''';

  checkPhase = ''
    tests/run-tests
  '';

  # Problem with a subprocess (parts)
  doCheck = false;

  # Requires CPython
  disabled = isPyPy;

  meta = with stdenv.lib; {
    description = "Python compiler with full language support and CPython compatibility";
    license = licenses.asl20;
    homepage = https://nuitka.net/;
  };

}
