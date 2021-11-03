{ config, pkgs, lib, inputs, ... }:
let
  secrets = import ../modules/secrets.nix;
in
{
  imports =
    [
    ../modules/laptop/common.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking.hostName = "innodellix";

  system.stateVersion = "20.09";

  boot = {
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
    kernelPackages = inputs.unstable.linuxPackages_latest;
    kernelParams = [
      "i915.enable_fbc=1"
      "i915.enable_guc=2"
      "i915.modeset=1"
      "video=eDP-1:1920x1200@60"
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
    };

  swapDevices = [
    {
      device = "/dev/mapper/vg0-swap";
      size = 8191;
    }
  ];

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

  hardware = {
    video.hidpi.enable = lib.mkDefault true;
    sensor.iio.enable = true;
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
  };
}
