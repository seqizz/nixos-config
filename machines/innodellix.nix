{ config, lib, pkgs, modulesPath, ... }:
let
  unstable = import (
    fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz
  ) { config = { allowUnfree = true; }; };
  secrets = import ../modules/secrets.nix;
  nixos_plymouth = pkgs.callPackage ../modules/packages/nixos-plymouth.nix {};
in
{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ../modules/laptop/common.nix
  ];

  networking = {
    hostName = "innodellix";
    networkmanager = {
      plugins = with pkgs; [
        networkmanager-openvpn
      ];
      enableStrongSwan = true;
    };
  };

  system.stateVersion = "20.09";

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "0";
      };
      efi.canTouchEfiVariables = true;
    };
    plymouth = {
      enable = true;
      theme = "nixos-blur";
      themePackages = [ nixos_plymouth ];
    };
    initrd = {
      availableKernelModules = [
        "ahci"
        "battery"
        "i915"
        "nvme"
        "rtsx_pci_sdmmc"
        "sd_mod"
        "usb_storage"
        "xhci_pci"
      ];
      luks.devices = {
        root = {
          preLVM = true;
          device = "/dev/nvme0n1p2";
        };
      };
    };
    kernelModules = [ "kvm-intel" "i915" ];
    # kernelPackages = pkgs.linuxPackages_6_1;
    kernelPackages = unstable.linuxPackages_latest;
    kernelParams = [
      # "i915.enable_fbc=1"
      # "i915.enable_guc=2"
      "i915.modeset=1"
      # "i915.mitigations=off"
      "video=eDP-1:1920x1200@60"
      # fking thunderbolt
      # "pci=assign-busses,hpbussize=0x33,realloc,hpmemsize=128M"
    ];
  };

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/5474a12e-4fcb-44cb-9107-e7f333392836";
      fsType = "btrfs";
      options = [
        "noatime"
        "nodiratime"
        "discard"
      ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/B74E-E1F3";
      fsType = "vfat";
      options = [
        "nofail"
      ];
    };

  powerManagement = {
    cpuFreqGovernor = lib.mkDefault "powersave";
    # Disable hid driver (gyro/accel) while sleeping
    powerDownCommands = ''
      ${pkgs.kmod}/bin/modprobe -r intel_hid
    '';
    resumeCommands = ''
      ${pkgs.kmod}/bin/modprobe intel_hid
    '';
  };

  zramSwap = {
    enable = true;
    memoryPercent = 20;
    swapDevices = 1;
  };

  hardware = {
    # video.hidpi.enable = lib.mkDefault true;
    sensor.iio.enable = true;
    printers.ensurePrinters = secrets.officePrinters;
  };

  services = {
    printing.drivers = [ pkgs.hplipWithPlugin ];
  };

  environment.etc = {
    "NetworkManager/system-connections/VPN-af.nmconnection" = {
      mode = "0600";
      text = secrets.afVpnConnectionConf;
    };
    "NetworkManager/system-connections/VPN-aw.nmconnection" = {
      mode = "0600";
      text = secrets.awVpnConnectionConf;
    };
    "NetworkManager/system-connections/VPN-P-aw.nmconnection" = {
      mode = "0600";
      text = secrets.awPVpnConnectionConf;
    };
  };
}
#  vim: set ts=2 sw=2 tw=0 et :
