{ config, lib, pkgs, ... }:

# Common options for all machines

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

  # When there is a false positive
  # nixpkgs.config.allowBroken = true;

  i18n = {
    defaultLocale = "en_DK.UTF-8";
  };

  time.timeZone = "Europe/Berlin";

  boot = {
    tmpOnTmpfs = true;
    kernel.sysctl = {
      "kernel.pty.max" = 24000;
      "kernel.sysrq" = 1;
      "vm.swappiness" = 0;
    };
    cleanTmpDir = true;
  };

  services = {
    journald.extraConfig = ''
      SystemMaxUse=1G
    '';
  };

  nix = {
    allowedUsers = [ "@wheel" ];
    package = pkgs.nixFlakes;
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
      experimental-features = nix-command flakes
    '';
  };
}
