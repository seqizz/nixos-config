{ config, lib, pkgs, ... }:
{

  networking.hostName = "innixos";

  imports = [
    ../modules/laptop/common.nix
  ];

  boot = {

    # @Reference if you want to modify kernel
    # kernelPatches = [{
    #  name = "enable-kmemleak";
    #  patch = null;
    #  extraConfig = ''
    #    DEBUG_KMEMLEAK y
    #  '';
    #}];

    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "video=eDP-1:1920x1080@60"
    ];

    kernelModules = [
      "acpi_call"
      "i2c-dev"
      "ddcci"
      "ddcci-backlight"
    ];
    extraModulePackages = with config.boot.kernelPackages; [
      acpi_call
      tp_smapi
      ddcci-driver
    ];

    initrd = {

      luks.devices."nixcrypt" = {
        device = "/dev/disk/by-uuid/d68365d0-19c8-4cb0-b891-1dd09ab3d558";
        allowDiscards = true;
      };

      availableKernelModules = [
        "acpi_call"
        "ahci"
        "battery"
        "i915"
        "rtsx_pci_sdmmc"
        "sd_mod"
        "thinkpad_acpi"
        "tp_smapi"
        "usb_storage"
        "usbhid"
        "xhci_pci"
      ];
    };

    loader.grub.device = "/dev/sda";
  };

  fileSystems = {

    "/" = {
      device = "/dev/disk/by-uuid/3201a948-6b32-4dba-9033-7c9ea039922e";
      fsType = "btrfs";
      options = [
        "noatime"
        "nodiratime"
        "compress-force=zstd:2"
      ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/3311203b-d097-4b83-9afa-29e864775815";
      fsType = "ext2";
    };
  };

  nix.maxJobs = lib.mkDefault 8;

  hardware.cpu.intel.updateMicrocode = true;

  system.stateVersion = "19.03";

  services = {
    xserver.videoDrivers = [ "intel" ];
    printing.drivers = [ pkgs.hplipWithPlugin ];
  };
}
