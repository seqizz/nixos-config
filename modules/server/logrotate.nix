{ lib, config, ... }:
{
  services.logrotate = {
    enable = true;
    paths = {
      snapper = {
        path = "/var/log/snapper.log";
        keep = 20;
      };
      nginx = {
        path = "/var/log/nginx/*.log";
        keep = 30;
        user = config.services.nginx.user;
        group = config.services.nginx.group;
      };
    };
  };
}
