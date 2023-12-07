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
      rev = "375d9d723550023f75ff0066122aba99fdbb2a93";
      sha256 = "0ycis7519d7znyaa2x9dxgs0asfr4w7xsb34lcifygnlwnz11hpm";
    };
    lua = super.lua5_3;
  });
}
