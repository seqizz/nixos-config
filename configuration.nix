{ config, pkgs, options, lib, ... }:
let
  importfile = ( if builtins.readFile "/sys/devices/virtual/dmi/id/product_name" == "XPS 13 9310 2-in-1\n" then
    ./machines/innodellix.nix
  else
    # This has to be manually symlinked per host
    /etc/nixos/special.nix
  );
in
{
  imports = [ importfile ];
}
#  vim: set ts=2 sw=2 tw=0 et :
