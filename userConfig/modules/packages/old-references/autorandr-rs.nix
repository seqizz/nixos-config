{rustPlatform, fetchFromGitHub, scdoc, installShellFiles}:

rustPlatform.buildRustPackage rec {
  name = "autorandr-rs";
  src = fetchFromGitHub {
    owner = "theotherjimmy";
    repo = name;
    rev = "c8cd814dcdb25551e9acc7b777979a73b2241612";
    sha256 = "1gaw2hjyvbrv7wwf1yr218avxdi6yfm4cshqvnf57mq4c024s7i8";
  };
  cargoSha256 = "14kascz4ifvmixq7w13vvnzq52q1b6ipw2wkdxarv5phmzmsbmi6";
  nativeBuildInputs = [ scdoc installShellFiles ];
  preFixup = ''
    installManPage $releaseDir/build/${name}-*/out/${name}.1
    installManPage $releaseDir/build/${name}-*/out/${name}.5
  '';
}
