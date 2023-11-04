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
      rev = "7ed4dd620bc73ba87a1f88e6f126aed348f94458";
      sha256 = "0qz21z3idimw1hlmr23ffl0iwr7128wywjcygss6phyhq5zn5bx3";
    };
    lua = super.lua5_3;
  });
}
