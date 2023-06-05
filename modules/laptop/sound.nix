{ config, lib, pkgs, ... }:
# @Reference see below
# let
  # signal_script = pkgs.writeScript "signal_script" ''
    # #!${pkgs.bash}/bin/bash -eu
    # ${pkgs.coreutils}/bin/coreutils --coreutils-prog=sleep 1
    # ${pkgs.dbus}/bin/dbus-send --system --type=signal / "$1"
  # '';
# in
{
  # @Reference for tunables of pulseaudio
  # sound.enable = true;
  # hardware = {
    # pulseaudio = {
      # enable = true;
      # package = pkgs.pulseaudioFull;
      # support32Bit = true;
      # extraModules = [ pkgs.pulseaudio-modules-bt ];
      # # @Reference to blacklist any devices' auto-switch
      # # load-module module-switch-on-connect blacklist=""
      # extraConfig = ''
        # load-module module-switch-on-connect blacklist="USB|Dock"
        # load-module module-alsa-card device_id="1" name="usb-Logitech_Logitech_G933_Gaming_Wireless_Headset-00" card_name="alsa_card.usb-Logitech_Logitech_G933_Gaming_Wireless_Headset-00" namereg_fail=false tsched=yes fixed_latency_range=yes ignore_dB=no deferred_volume=yes use_ucm=yes avoid_resampling=yes card_properties="module-udev-detect.discovered=1" tsched_buffer_size=65536 tsched_buffer_watermark=20000
      # '';
    # };
  # };

  security.rtkit.enable = true;
  environment.systemPackages = with pkgs; [
    pulseaudio
  ];

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # config.pipewire-pulse."context.exec" = [
      #   { "path" = "${pkgs.pulseaudio}/bin/pactl"; "args" = "load-module module-switch-on-connect blacklist=\"USB|Dock\""; }
      # ];
    };

    # @Reference: Emit a new DBUS signal, if new sound device added
    # udev.extraRules = lib.mkMerge [
      # ''ACTION=="add",	SUBSYSTEM=="sound", ENV{ID_TYPE}=="audio", RUN+="${signal_script} org.custom.gurkan.sound_device_added"''
      # ''ACTION=="remove",	SUBSYSTEM=="sound", ENV{DEVPATH}=="*/card[0-9]", ENV{ID_TYPE}=="audio", RUN+="${signal_script} org.custom.gurkan.sound_device_removed"''
    # ];
  };
}
#  vim: set ts=2 sw=2 tw=0 et :
