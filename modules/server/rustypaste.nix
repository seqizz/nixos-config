{ config, pkgs, lib, ...}:
let
  secrets = import ../secrets.nix;
  baseconfig = { allowUnfree = true; };
  unstable = import (
    fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz
  ) { config = baseconfig; };
in
{
  users.users.rustypaste = {
    isSystemUser = true;
    group = "nogroup";
  };

  # Systemd definitions
  systemd.services.rustypaste = {
    enable = true;
    wantedBy = [
      "multi-user.target"
    ];
    description = "Paste service";
    environment = {
      AUTH_TOKEN = secrets.rustypasteToken;
      CONFIG = "/shared/rustypaste/config.toml";
    };
    serviceConfig = {
      User = "rustypaste";
      ExecStart = "${unstable.rustypaste}/bin/rustypaste";
      Restart = "always";
      RestartSec = 30;
      StandardOutput = "syslog";
      WorkingDirectory = "/shared/rustypaste";
    };
  };
}
