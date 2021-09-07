{ config, pkgs, options, lib, ... }:
{
  imports =
  [
    # This has to be manually symlinked per host
    /etc/nixos/special.nix
  ];
}
