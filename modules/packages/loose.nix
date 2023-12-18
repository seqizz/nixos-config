{ lib
, fetchgit
, pkgs
, python3Packages
}:
let
  latest-jc = pkgs.jc.overrideAttrs (old: {
    src = pkgs.fetchFromGitHub {
      owner = "kellyjonbrazil";
      repo = "jc";
      rev = "dev";
      sha256 = "sha256-+DWhbFUQ80pPLquAMNL8EH8b4y0oe5qlnd0HEuhGPwE=";
    };
  });
  pyedid = python3Packages.callPackage ./pyedid.nix {};
in
python3Packages.buildPythonApplication rec {

  pname = "loose";
  version = "unstable-2023-12-17";
  pyproject = true;

  src = fetchgit {
    url = "https://git.gurkan.in/gurkan/loose.git";
    rev = "ee2c1b9f0bd5cd7f117a542091368b118b5ca06f";
    sha256 = "0azvnfk1qd1kxjph9d8di2ffp0fi7phrrimgn5rlj4vzngxpqrws";
  };

  nativeBuildInputs = with python3Packages; [
    poetry-core
  ];

  propagatedBuildInputs = with python3Packages; [
    latest-jc
    pyyaml
    pykwalify
    xdg-base-dirs
    pkgs.xorg.xrandr
    pyedid
    pkgs.xorg.xrdb  # Helps for setting dpi
  ];

  doInstallCheck = false;
  doCheck = false;

  meta = with lib; {
    description = "Another xrandr wrapper for multi-monitor setups";
    homepage = https://git.gurkan.in/gurkan/loose;
    license = licenses.gpl3;
    maintainers = [ "seqizz" ] ;
    platforms = platforms.linux;
  };
}
