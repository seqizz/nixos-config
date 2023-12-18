{ config, pkgs, lib, ... }:
{
  services = {
    udev.extraRules = ''
      ACTION=="change", SUBSYSTEM=="drm", ENV{XDG_RUNTIME_DIR}="/run/user/1000", ENV{DBUS_SESSION_BUS_ADDRESS}="unix:path=/run/user/1000/bus", RUN+="${pkgs.su}/bin/su gurkan -c \"${pkgs.systemd}/bin/systemctl --user restart loose\""
    '';
  };

  powerManagement = {
    resumeCommands = ''
      ${pkgs.su}/bin/su gurkan -c "XDG_RUNTIME_DIR=/run/user/1000 DBUS_SESSION_BUS_ADDRESS='unix:path=/run/user/1000/bus' ${pkgs.systemd}/bin/systemctl --user restart loose"
    '';
  };
}
