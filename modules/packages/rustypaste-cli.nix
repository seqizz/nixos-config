{ stdenv
, lib
, fetchurl
}:

stdenv.mkDerivation rec {
  name = "rustypaste-cli";
  version = "0.3.0";

  src = fetchurl {
    url = "https://github.com/orhun/rustypaste-cli/releases/download/v0.3.0/rustypaste-cli-0.3.0-x86_64-unknown-linux-musl.tar.gz";
    sha256 = "1533wqxgycvmh8c8zryjlvkhi8nh6ffyc6dpm0a42b5zry2l4hwq";
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
