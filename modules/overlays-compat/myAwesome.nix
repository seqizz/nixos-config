self: super:
{
  myAwesome = super.awesome.overrideAttrs (old: rec {
    pname = "myAwesome";
    src = super.fetchFromGitHub {
      owner = "awesomeWM";
      repo = "awesome";
      rev = "8a81745d4d0466c0d4b346762a80e4f566c83461";
      sha256 = "031x69nfvg03snkn7392whg3j43ccg46h6fbdcqj3nxqidgkcf76";
      # owner = "Elv13";
      # repo = "awesome-1";
      # rev = "f4301592cc56d37096a96634adbed9afe50e78f7";
      # sha256 = "1qgpkxxv49ka2pq8jy5yahazd83jxibrqmnw99rb97algq677mv0";
    };
  });
}
