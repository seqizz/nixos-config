# Video4Linux
#
# For screencasting.

{ config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.hardware.v4l2loopback;
in

{
  options.hardware.v4l2loopback= {
    enable = mkEnableOption "Video4Linux";
  };

  config = mkIf cfg.enable {
    boot.extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1
      options v4l2loopback video_nr=5
    '';

    boot.extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];

    boot.kernelModules = [
      "v4l2loopback"
    ];

    environment.systemPackages = with pkgs; [
      v4l-utils
    ];
  };
}
