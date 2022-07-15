{ lib, config, ... }:
{
  services.logrotate = {
    enable = true;
    settings = {
      "/var/log/snapper.log" = {
        rotate = 20;
        daily = "";
        notifempty = "";
        compress = "";
        missingok = "";
      };
    };
  };
}
#  vim: set ts=2 sw=2 tw=0 et :
