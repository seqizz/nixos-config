{ pkgs, config, lib, ... }:
{
  # Packages not needed in servers
  environment.systemPackages = with pkgs; [
    acpi
    adoptopenjdk-bin
    dnscrypt-proxy2
    geteltorito # for converting iso to img
    iw
    linuxPackages.cpupower
    lm_sensors
    powertop
    ruby # I am not ashamed
    samba
    wirelesstools
  ];
}
