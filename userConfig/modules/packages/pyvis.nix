{ lib
, buildPythonPackage
, pythonOlder
, fetchFromGitHub
, jinja2
, ipython
, networkx
, jsonpickle
}:

buildPythonPackage rec {
  pname = "pyvis";
  version = "0.0.1";
  format = "pyproject";
  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = "WestHealth";
    repo = pname;
    rev = "4c521302abf9725dcbe7f59962baf85360b2718d";
    sha256 = "13qrxls89sgx1f2381wb8lrs3w4vfb4ik09rdy5zhjbdki1cg1hd";
  };

  # preConfigure = ''
    # patchShebangs autogen.sh
    # ./autogen.sh
  # '';

  # patches = [ ./build_poetry.patch ];

  # checkInputs = [ pytestCheckHook ];

  # Despite living in 'tool.poetry.dependencies',
  # these are only used at build time to process the image resource files
  nativeBuildInputs = [ jinja2 ipython networkx jsonpickle ];

  propagatedBuildInputs = nativeBuildInputs;

  meta = with lib; {
    description = "Diagram as Code";
    homepage    = "https://diagrams.mingrammer.com/";
    license     = licenses.mit;
    maintainers =  with maintainers; [ addict3d ];
  };
}

