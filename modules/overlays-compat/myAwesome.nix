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
      owner = "awesomeWM";
      repo = "awesome";
      rev = "a436478731936812e82ef17b78cc4979d5db6ad6";
      sha256 = "1j4wyqfm7p6bqq6z5c9h5q7klqgfabq3p2351r0n6473x3780myc";
    };
    lua = super.lua5_3;
  });
}
