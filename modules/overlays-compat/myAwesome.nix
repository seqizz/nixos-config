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
      owner = "awesomewm";
      repo = "awesome";
      rev = "1f7ac8f9c7ab9fff7dd93ab4b29514ff3580efcf";
      sha256 = "173flmzkwsf4a5v2zxpvbqxzz5rgr7zis0zrvna4s6kgh6ir740g";
    };
    lua = super.lua5_3;
  });
}
