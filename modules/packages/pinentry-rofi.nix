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
  version = "unstable-2023-03-19";

  src = fetchFromGitHub {
    owner = "plattfot";
    repo = "pinentry-rofi";
    rev = "eecf19bb876f2d5523a88a5a06e4bee7bff46730";
    sha256 = "1a58slidg9alrs1c8flbm46jpjli84kxjcxaxih98icbb52hzyln";
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
