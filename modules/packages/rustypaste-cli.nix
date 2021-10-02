{ stdenv
, lib
, fetchurl
}:

stdenv.mkDerivation rec {
  name = "rustypaste-cli";
  version = "0.1.2";

  src = fetchurl {
    url = "https://github.com/orhun/rustypaste-cli/releases/download/v${version}/rustypaste-cli-${version}-x86_64-unknown-linux-musl.tar.gz";
    sha256 = "148zsmywilxk0cwvl81m99ffay54lnmhxnz7kzq6qy2nx7h6yz8y";
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
