{ stdenv
, rustPlatform
, makeRustPlatform
, lib
, fetchFromGitHub
, pkg-config
, rust-bin  # Comes from https://github.com/oxalica/rust-overlay
}:
rustPlatform.buildRustPackage {
  name = "rustypaste";
  src = fetchFromGitHub {
    owner = "orhun";
    repo = "rustypaste";
    rev = "0296bc05949a857fd0749759739c19893ce1460f";
    fetchSubmodules = true;
    sha256 = "0f7cyh72ndb3bhvsms6mxl80b29d3xd6cc0gnrqliji4hn3klq7w";
  };
  cargoSha256 = "1fp9ihny1jzsrjgywjbnajj36nmm3v40j110d39wavy6cqjk2rp7";

  nativeBuildInputs = [
    pkg-config
    rust-bin.stable.latest.default
  ];

  preBuildPhases = ["preBuildPhase"];
  preBuildPhase = ''
    substituteInPlace src/server.rs \
    --replace 'env!("CARGO_PKG_HOMEPAGE")' '"https://gurkan.in/"' \
  '';

  doCheck = false;

  meta = with lib; {
    description = "A minimal file upload/pastebin service";
    homepage = "https://github.com/orhun/rustypaste";
    license = licenses.mit;
    maintainers = with maintainers; [ seqizz ];
    platforms = platforms.unix;
  };
}
