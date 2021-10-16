{ config, lib, pkgs, ... }:
{
  sound.enable = true;

  hardware = {
    # WTH is pulseaudio under hardware section?
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      support32Bit = true;
      extraModules = [ pkgs.pulseaudio-modules-bt ];
      # @Reference to blacklist any devices' auto-switch
      # load-module module-switch-on-connect blacklist=""
      extraConfig = ''
        load-module module-switch-on-connect blacklist="hdmi|Dock"
        load-module module-alsa-card device_id="1" name="usb-Logitech_Logitech_G933_Gaming_Wireless_Headset-00" card_name="alsa_card.usb-Logitech_Logitech_G933_Gaming_Wireless_Headset-00" namereg_fail=false tsched=yes fixed_latency_range=yes ignore_dB=no deferred_volume=yes use_ucm=yes avoid_resampling=yes card_properties="module-udev-detect.discovered=1" tsched_buffer_size=65536 tsched_buffer_watermark=20000
      '';
    };
  };

  services.udev.extraRules = lib.mkMerge [
    # Emit a new DBUS signal, if new sound device added
    ''ACTION=="add",	SUBSYSTEM=="sound", ENV{ID_TYPE}=="audio", RUN+="${pkgs.dbus}/bin/dbus-send --system --type=signal / org.custom.gurkan.sound_device_added"''
    ''ACTION=="remove",	SUBSYSTEM=="sound", ENV{DEVPATH}=="*/card[0-9]", ENV{ID_TYPE}=="audio", RUN+="${pkgs.dbus}/bin/dbus-send --system --type=signal / org.custom.gurkan.sound_device_removed"''
  ];

}

