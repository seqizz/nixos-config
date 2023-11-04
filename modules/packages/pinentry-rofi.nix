{ stdenv
, lib
, fetchFromGitHub
, pkg-config
, autoreconfHook
, autoconf-archive
, guile
, texinfo
, rofi
}:

stdenv.mkDerivation rec {
  pname = "pinentry-rofi";
  version = "unstable-2023-07-10";

  src = fetchFromGitHub {
    owner = "plattfot";
    repo = "pinentry-rofi";
    rev = "96f0ce5ccc8fdf43c3762103ce6a2379448050ed";
    sha256 = "1zg7203p1hcmvm1yfn4ajnvn8f6kiqjw79vyabf5xawlj8h0h19n";
  };

  nativeBuildInputs = [
    autoconf-archive
    autoreconfHook
    pkg-config
    texinfo
  ];

  buildInputs = [ guile ];

  propagatedBuildInputs = [ rofi ];

  meta = with lib; {
    description = "Rofi frontend to pinentry";
    homepage = "https://github.com/plattfot/pinentry-rofi";
    license = licenses.gpl3Plus;
    platforms = platforms.unix;
  };
}
