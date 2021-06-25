self: super:
{
  myAwesome = super.awesome.overrideAttrs (old: rec {
    pname = "myAwesome";
    version = "git-20200926-59ff7c";
    src = super.fetchFromGitHub {
      # owner = "awesomeWM";
      # repo = "awesome";
      # rev = "7a759432d3100ff6870e0b2b427e3352bf17c7cc";
      # sha256 = "0kjndz8q1cagmybsc0cdw97c9ydldahrlv140bfvl1xzhhbmx0hg";
      owner = "Elv13";
      repo = "awesome-1";
      rev = "59ff7c2d3413c5212bac05ea3ca7122f790cfcc7";
      sha256 = "0pp94gmrmrk74n6i7svairxlfymxbfp1bkav43ihjl9fi9d0jq4p";
    };
  });
}
