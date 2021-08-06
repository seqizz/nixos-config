{ pkgs }:
{
  # Wrap scripts into programs
  writeSubbedBin = args:
    pkgs.substituteAll (args // {
      dir = "bin";
      isExecutable = true;
      shell = pkgs.bash;
    });
}
