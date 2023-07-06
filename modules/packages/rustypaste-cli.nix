{ stdenv
, lib
, fetchurl
}:

stdenv.mkDerivation rec {
  name = "rustypaste-cli";
  version = "0.5.0";

  src = fetchurl {
    url = "https://github.com/orhun/rustypaste-cli/releases/download/v0.5.0/rustypaste-cli-0.5.0-x86_64-unknown-linux-musl.tar.gz";
    sha256 = "143vjqlldyr1j6xn928bqp32n4ay1cnwkfh5ihdhmhiqk4myhfzy";
  };

  unpackPhase = ''
    tar xvf ${src}
  '';

  installPhase = ''
    install -m755 -D rustypaste-cli-${version}/rpaste $out/bin/rpaste
  '';

  meta = with lib; {
    homepage = https://github.com/orhun/rustypaste-cli;
    description = "A minimal file upload/pastebin service, cli tool";
    platforms = platforms.linux;
    maintainers = with maintainers; [ seqizz ];
  };
}
