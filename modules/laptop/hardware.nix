{ config, lib, pkgs, ... }:
{
  imports = [ ./helper-modules/usb-wakeup-disable.nix ];

  hardware = {
    bluetooth.enable = true;
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

    # WTH is pulseaudio under hardware section?
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      support32Bit = true;
      extraModules = [ pkgs.pulseaudio-modules-bt ];
      # @Reference to blacklist any devices' auto-switch
      # load-module module-switch-on-connect blacklist=""
      extraConfig = ''
        load-module module-switch-on-connect blacklist="hdmi|USB Audio"
        load-module module-alsa-card device_id="1" name="usb-Logitech_Logitech_G933_Gaming_Wireless_Headset-00" card_name="alsa_card.usb-Logitech_Logitech_G933_Gaming_Wireless_Headset-00" namereg_fail=false tsched=yes fixed_latency_range=yes ignore_dB=no deferred_volume=yes use_ucm=yes avoid_resampling=yes card_properties="module-udev-detect.discovered=1" tsched_buffer_size=65536 tsched_buffer_watermark=20000
      '';
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
