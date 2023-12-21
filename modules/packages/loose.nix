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
  version = "unstable-2023-12-21";
  pyproject = true;

  src = fetchgit {
    url = "https://git.gurkan.in/gurkan/loose.git";
    rev = "59a76f91be0458ee2989886f37163fb131ff56c7";
    sha256 = "0pvb5qaqliyslyz4gck0i8jd86bz4631zrnj2p96iqhjd2rjjxk4";
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
    pkgs.xorg.xrdb  # Helps for setting dpi etc
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
