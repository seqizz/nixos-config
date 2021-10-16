{ config, lib, pkgs, ... }:
{
  imports = [
    ./helper-modules/usb-wakeup-disable.nix
    ./helper-modules/v4l2loopback.nix
  ];

  hardware = {
    bluetooth.enable = true;
    v4l2loopback.enable = true;
    logitech.wireless.enable = true;
    keyboard.zsa.enable = true;
    enableRedistributableFirmware = true;

    firmware = [ pkgs.firmwareLinuxNonfree ];

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
        intel-media-driver
      ];
    };

    usb.wakeupDisabled = [
      {
        # Logitech G413 gaming keyboard
        vendor = "046d";
        product = "c33a";
      }
      {
        # Logitech unifying receiver (mouse)
        vendor = "046d";
        product = "c52b";
      }
      {
        # ZSA Moonlander
        vendor = "3297";
        product = "1969";
      }
    ];
  };
}
