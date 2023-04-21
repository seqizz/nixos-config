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
      rev = "b54e50ad6cfdcd864a21970b31378f7c64adf3f4";
      sha256 = "1cd1jirhndss583agxrapq9wf6q7m27gv95wdmx4bbzrykac4df8";
    };
    lua = super.lua5_3;
  });
}
