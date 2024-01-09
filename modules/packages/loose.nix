{ lib
, fetchgit
, pkgs
, installShellFiles
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
  version = "unstable-2024-01-04";
  pyproject = true;

  src = fetchgit {
    url = "https://git.gurkan.in/gurkan/loose.git";
    rev = "af397b6f73853afdabb0c31efadaaf2740474581";
    sha256 = "1ln65204scfwlnzb5gh2k3haw4x44ckqsfzimdmnar7hvwhav4fp";
  };

  nativeBuildInputs = with python3Packages; [
    poetry-core
    installShellFiles
  ];

  buildInputs = with python3Packages; [
    shtab # For command line completion
  ];

  propagatedBuildInputs = with python3Packages; [
    latest-jc
    pyyaml
    yamale
    xdg-base-dirs
    pkgs.xorg.xrandr
    pyedid
  ];

  # Sadly shtab doesn't have fish completion yet
  postInstall = ''
    installShellCompletion --cmd loose \
      --bash <($out/bin/loose -s bash) \
      --zsh <($out/bin/loose -s zsh)
  '';

  meta = with lib; {
    description = "Another xrandr wrapper for multi-monitor setups";
    homepage = https://git.gurkan.in/gurkan/loose;
    license = licenses.gpl3;
    maintainers = [ "seqizz" ] ;
    platforms = platforms.linux;
  };
}
