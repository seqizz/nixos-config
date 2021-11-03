{config, pkgs, ...}:
let
  secrets = import ./secrets.nix {pkgs=pkgs;};
in
{
  programs.ssh = {
    enable = true;
    serverAliveInterval = 60;
    hashKnownHosts = true;
    matchBlocks = secrets.sshMatchBlocks;
  };
}
