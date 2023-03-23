{ config, pkgs, ... }:
{
  services = {
    autorandr.enable = true;
    udev.extraRules = ''ACTION=="change", SUBSYSTEM=="drm", RUN+="${pkgs.autorandr}/bin/autorandr -c"'';
  };

  powerManagement = {
    resumeCommands = ''
      ${pkgs.autorandr}/bin/autorandr -c
    '';
  };
}
