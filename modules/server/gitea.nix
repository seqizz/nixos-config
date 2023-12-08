{ lib, config, ... }:
let
  baseconfig = { allowUnfree = true; };
  unstable = import (
  fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz
  ) { config = baseconfig; };
in
{
  services.gitea = {
    enable = true;
    package = unstable.gitea;
    appName = "My git forks";
    extraConfig = ''
      [DEFAULT]
      WORK_PATH=/var/lib/gitea
    '';
    settings = {
      service.DISABLE_REGISTRATION = true;
      log.LEVEL= "Warn";
      repository = {
        DEFAULT_REPO_UNITS = "repo.code,repo.releases";
        DEFAULT_BRANCH = "master";
      };
      server = {
        ROOT_URL = "https://git.gurkan.in";
        HTTP_ADDR = "127.0.0.1";
        DOMAIN = "git.gurkan.in";
        LANDING_PAGE = "explore";
      };
      ui = {
        SHOW_USER_EMAIL = false;
        DEFAULT_THEME = "arc-green";
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
