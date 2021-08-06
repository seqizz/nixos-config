{ config, lib, pkgs, ... }:
{
  imports =
  [
    ./aliases.nix
    ./gitconfig.nix
    ./neovim.nix
    ./overlays.nix
    ./packages.nix
    ./scripts.nix
    ./snapper.nix
    ./syncthing.nix
    ./users.nix
  ];
}
