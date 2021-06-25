{ config, pkgs, options, lib, ... }:
{
  imports =
  [
    # This has to be manually symlinked per host
    /etc/nixos/special.nix
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
      "vm.swappiness" = 10;
    };
    cleanTmpDir = true;
  };

  services = {
    journald.extraConfig = ''
      SystemMaxUse=1G
    '';
  };

  nix = {
    # package = pkgs.nixFlakes;
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
      # experimental-features = nix-command flakes
    '';
  };
}
