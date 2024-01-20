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
  version = "unstable-2024-01-18";
  pyproject = true;

  src = fetchgit {
    url = "https://git.gurkan.in/gurkan/loose.git";
    rev = "5db982490c87f2546702f306515f0e326698e080";
    sha256 = "1zn0ibz6azdcxvz0z0afz8inkz03650zp4hzwfanb3dflf85af14";
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
