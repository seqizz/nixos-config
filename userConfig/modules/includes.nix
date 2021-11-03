{ config, ... }:
{
  imports =
  [
    ./packages.nix
    ./services.nix
    ./programs.nix
    ./variables.nix
    ./ssh.nix
    ./files.nix
    ./xserver.nix
  ];
}
