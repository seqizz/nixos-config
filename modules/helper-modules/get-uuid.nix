{ pkgs
, baseText
}:

# An UUID generator derivation
# Same baseText will always generate the same UUID
pkgs.stdenv.mkDerivation {
  name = "uuid-generator-${baseText}";

  nativeBuildInputs = [ pkgs.util-linux ];

  buildCommand = ''
      mkdir -p $out
      uuidgen -s -N ${baseText} -n @url > $out/outFile
  '';
}
