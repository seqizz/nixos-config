{ config, lib, pkgs, ... }:
{
  networking.hostName = "nixosis";

  imports = [
    ../modules/laptop/common.nix
  ];

  boot = {

    kernelModules = [ "kvm-intel" ];
    kernelPackages = unstable.linuxPackages_latest;
    kernelParams = [ "video.report_key_events=0 video=eDP-1:1920x1080@48" ];

    extraModprobeConfig = ''
      options ath10k_core skip_otp=y
    '';

    initrd = {

      availableKernelModules = [
        "ahci"
        "ehci_pci"
        "i915"
        "rtsx_pci_sdmmc"
        "sd_mod"
        "usb_storage"
        "xhci_pci"
      ];

      luks.devices."nixos" = {
        device = "/dev/disk/by-uuid/342a3bc9-ad42-48e8-ac63-f593e15ed796";
        allowDiscards = true;
      };
    };

    loader = {

      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = true;
        consoleMode = "auto";
      };
    };
  };

  fileSystems = {

    "/" = {
      device = "/dev/disk/by-uuid/aa5c5d6a-ff10-4ffd-bf87-a4e7140ae32f";
      fsType = "btrfs";
      options = [
        "noatime"
        "nodiratime"
        "compress-force=zstd:2"
      ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/19A6-F429";
      fsType = "vfat";
    };
  };

  nix.maxJobs = lib.mkDefault 8;

  hardware = {
    cpu.intel.updateMicrocode = true;
    # bumblebee.enable = true;
  };

  system.stateVersion = "19.03";

  # Because ACPI is a pile of shit and MSI is the fly buzzing around it
  systemd.services."fuck-msi-shit-lid"= {
    enable = true;
    wantedBy = [
      "multi-user.target"
      "graphical-session.target"
    ];
    description = "Probing the LID state like a MORON because of fuckin MSI";
    script = "while true; do cat /proc/acpi/button/lid/LID0/state > /dev/null ; sleep 2; done";
    serviceConfig = {
      Restart = "always";
      RestartSec = 2;
      StartLimitIntervalSec = 0;
    };
  };

  powerManagement = {
    cpuFreqGovernor = lib.mkDefault "powersave";
    powerDownCommands = ''
      ${pkgs.utillinux}/bin/rfkill block wlan
    '';
    resumeCommands = ''
      ${pkgs.utillinux}/bin/rfkill unblock wlan
    '';
  };

  services.xserver.resolutions = [
    { x = 1920; y = 1080; }
    { x = 1600; y = 1200; }
    { x = 1024; y = 786; }
  ];
}
