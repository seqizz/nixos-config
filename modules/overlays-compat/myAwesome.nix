self: super:
{
  myAwesome = super.awesome.overrideAttrs (old: rec {
    pname = "myAwesome";
    patches = [ ];
    postPatch = ''
      chmod +x /build/source/tests/examples/_postprocess.lua
      patchShebangs /build/source/tests/examples/_postprocess.lua
    '';
    src = super.fetchFromGitHub {
      owner = "BarbUK";
      repo = "awesome";
      rev = "5daae2bb5d90117eb341ad72eb123c4e6804b780";
      sha256 = "sha256-o69if8HQw2u0fp5J7jkS4WQeAXVuiFwpDLzGFscP4mM=";
    };
    lua = super.lua5_3;
  });
}
