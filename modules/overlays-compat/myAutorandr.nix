self: super:
{
  autorandr = super.autorandr.overrideAttrs (old: rec {
    src = super.fetchFromGitHub {
      owner = "seqizz";
      repo = "autorandr";
      rev = "5d3b326";
      sha256 = "0a2nsvidcj7y343axbfh3nvxyys03ni43cradlj6xkhmqk0yjkd1";
    };
  });
}
