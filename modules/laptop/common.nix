{ config, lib, pkgs, ... }:
let
  secrets = import ../secrets.nix;
in
{
  imports =
  [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>

    ../common.nix

    ./dnscrypt.nix
    ./fonts.nix
    ./hardware.nix
    ./iphone.nix
    ./networking.nix
    ./packages.nix
    ./services.nix
    ./sound.nix
    ./xserver.nix
    ./yubikey.nix
  ];

  console = {
    keyMap = "trq";
    # Good for HiDPI on TTY
    font = "latarcyrheb-sun32";
  };

  security.sudo.wheelNeedsPassword = false;

  users = {
    groups.gurkan.gid = 1000;
    users = {
      gurkan = {
        isNormalUser = true;
        uid = 1000;
        shell = pkgs.zsh;
        createHome = true;
        home = "/home/gurkan";
        group = "gurkan";
        extraGroups = [
          "adbusers"
          "adm"
          "audio"
          "disk"
          "docker"
          "input"
          "networkmanager"
          "vboxusers"
          "video"
          "wheel"
        ];
        hashedPassword = secrets.gurkanPassword;
      };
      root = {
        hashedPassword = secrets.rootPassword;
      };
    };
  };

  # Powersave
  boot = {
    extraModprobeConfig = lib.mkMerge [
      "options snd_hda_intel power_save=1 power_save_controller=Y"
      "options iwlwifi power_save=1 uapsd_disable=1 power_level=5"
      "options i915 enable_dc=4 enable_fbc=1 enable_guc=2 enable_psr=1 disable_power_well=1"
      "options iwlmvm power_scheme=3"
    ];
    kernelParams = ["intel_pstate=disable"];
  };
}
