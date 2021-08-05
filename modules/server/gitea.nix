{ lib, config, ... }:
{
  services.gitea = {
    enable = true;
    rootUrl = "https://git.gurkan.in";
    appName = "My git forks";
    httpAddress = "127.0.0.1";
    log.level = "Warn";
    domain = "git.gurkan.in";
    disableRegistration = true;
    settings = {
      server = {
        LANDING_PAGE = "explore";
      };
      "ui.meta" = {
        DESCRIPTION = "This is where I fork my stuff";
      };
      other = {
        SHOW_FOOTER_VERSION = false;
      };
    };
  };
}
