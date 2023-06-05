{ config, lib, pkgs, ... }:
let
  secrets = import ./secrets.nix;
in
# Common options for all of my machines
{
  imports =
  [
    ./aliases.nix
    ./gitconfig.nix
    ./neovim.nix
    ./overlays.nix
    ./packages.nix
    ./scripts.nix
    ./sheldon.nix
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
    tmp = {
      useTmpfs = true;
      cleanOnBoot = true;
    };
    kernel.sysctl = {
      "kernel.pty.max" = 24000;
      "kernel.sysrq" = 1;
      "vm.swappiness" = 0;
    };
  };

  services = {
    journald.extraConfig = ''
      SystemMaxUse=1G
    '';
  };

  nix = {
    settings.allowed-users = [ "@wheel" ];
    package = pkgs.nixFlakes;
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
      experimental-features = nix-command flakes
      access-tokens = github.com=${secrets.githubRateLimitAccessToken}
    '';
  };
}
#  vim: set ts=2 sw=2 tw=0 et :
